class PrintIOService
  include HTTParty
  base_uri( (Rails.env.production? ? 'https://api.print.io/' : 'http://staging.api.print.io/') + 'api/v/1/source/api')

  attr_accessor :order, :order_items, :user

  def initialize order
    @order = order
    @user = order.user
    @order_items = order.order_items
  end

  def post_order
    @result = self.class.post(
      "/orders?recipeid=#{PRINT_IO_RECIPE}",
      :body => serialize_for_post.to_json,
      :headers => { 'Content-Type' => 'application/json' }
    )

    transition_order
  end

  def ok?
    if @result
      @result.ok? #httparty has a result method which returns a boolean
    else
      puts @result
      false
    end
  end

  def serialized_items
    items = @order_items.map do |item|
      {
        'Quantity' => item.quantity,
        'SKU' => item.product.api_name, #dangerous, and should change the api_name to SKU
        'ShipType' => 'Standard', #for now
        'Images' => [
          {
            # 'Url' => 'ENV['ROOT_URL'] + item.quote_note.full_size_image_url',
            'Url' => 'http://awesome.com/image.jpg'
          }
        ]
      }
    end

    items
  end

  def serialize_for_post
    serialized_order = {
      'ShipToAddress' => {
        'FirstName' => user.name.split.first, # need to fix this.
        'LastName' => user.name.split.last,
        'Line1' => user.address,
        'City' => user.city,
        'CountryCode' => user.country,
        'State' => user.us_state,
        'PostalCode' => user.postal_code,
        'Phone' => user.phone,
        'Email' => user.email
      },

      'Items' => serialized_items,
      'Payment' => {
        'PartnerBillingKey' => PRINT_IO_API
      },
      'IsPreSubmit' => false,
      'SourceId' => order.id
    }
  end

  private

  def transition_order
    if ok?
      order.make_api_call!(@result)
    else
      order.fail_api_call!(@result)
    end
  end
end
