class PrintIOService
  include HTTParty
  base_uri( (Rails.env.production? ? 'https://api.print.io/' : 'http://staging.api.print.io/') + 'api/v/1/source/api')

  attr_accessor :order

  def initialize order
    @order = order
  end
end
