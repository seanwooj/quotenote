class PrintIOService
  include HTTParty
  base_uri( (Rails.env.production? ? 'https://api.print.io/' : 'http://staging.api.print.io/') + 'api/v/1/source/api')

  attr_accessor :order, :order_items, :user

  def initialize order
    @order = order
    @user = order.user
    @order_items = order.order_items
  end

  def serialized_items
    items = @order_items.map do |item|
      {
        'SKU' => item.product.api_name, #dangerous, and should change the api_name to SKU
        'ShipType' => 'Standard', #for now
        'Images' => [
          {
            'Url' => '',
            'Index' => 1,
            'SpaceId' => ''
          }
        ]
      }
    end

    items
  end

  def serialize_for_post
    order = {
      'ShipToAddress' => {
        'FirstName' => user.name.split.first, # need to fix this.
        'LastName' => user.name.split.last,
        'Line1' => user.address,
        'City' => user.city,
        'CountryCode' => user.country,
        'PostalCode' => user.postal_code,
        'Phone' => user.phone,
        'Email' => user.email
      },

      'Items' => serialized_items
    }
  end
end
