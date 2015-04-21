class PrintIOService
  include HTTParty
  base_uri( (Rails.env.production? ? 'https://api.print.io/' : 'http://staging.api.print.io/') + 'api/v/1/source/api')

  attr_accessor :order, :order_items, :user

  def initialize order
    @order = order
    @user = order.user
    @order_items = order.order_items
  end

  def serialize_for_post
    order = {
      'ShipToAddress' => {
        'FirstName' => user.name, # need to fix this.
        'LastName' => user.name,
        'Line1' => user.address,
        'City' => user.city,
        'CountryCode' => user.country,
        'PostalCode' => user.postal_code,
        'Phone' => user.phone,
        'Email' => user.email
      }
    }
  end
end
