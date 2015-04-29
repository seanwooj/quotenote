class PrintIOService
  include HTTParty
  base_uri( (Rails.env.production? ? 'https://api.print.io/' : 'http://staging.api.print.io/') + 'api/v/1/source/api')

  attr_accessor :order, :order_items, :user

  def initialize order
    @order = order
    @user = order.user
    @order_items = order.order_items
  end

  def generate_print_images
    @order_items.each do |item|
      Generator.generate_and_save item.quote_note, {:height => item.product.height_string, :width => item.product.width_string}
    end
  end

  def post_order
    generate_print_images

    @result = self.class.post(
      "/orders?recipeid=#{PRINT_IO_RECIPE}",
      :body => serialize_for_post.to_json,
      :headers => { 'Content-Type' => 'application/json' }
    )

    transition_order
  end

  def ok?
    if @result
      @result.ok? && !@result["Errors"]
    else
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
            'Url' => item.quote_note.image.url
          }
        ]
      }
    end

    items
  end

  def serialize_for_post
    serialized_order = {
      'ShipToAddress' => {
        'FirstName' => user.first_name,
        'LastName' => user.last_name,
        'Line1' => user.address,
        'City' => user.city,
        'CountryCode' => user.country,
        'State' => user.state,
        'PostalCode' => user.postal_code,
        'Phone' => user.phone,
        'Email' => user.email
      },

      'Items' => serialized_items,
      'Payment' => {
        'PartnerBillingKey' => PRINT_IO_API,
        'Total' => order.total_price
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
