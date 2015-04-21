require 'test_helper'

describe PrintIOService do
  it 'points to the correct endpoint' do
    PrintIOService.base_uri.must_equal "http://staging.api.print.io/api/v/1/source/api"
  end

  it 'serializes the data in the correct format' do
    order = create(:order)
    order.order_items << create(:order_item)
    ps = PrintIOService.new(order)
    ps.serialize_for_post.must_equal serialized_data
  end

end

def serialized_data
  {
    'ShipToAddress' => {
      'FirstName' => 'Test',
      'LastName' => 'User',
      'Line1' => '123 test address',
      'City' => 'Los Angeles',
      'CountryCode' => 'US',
      'PostalCode' => '94608',
      'Phone' => '5555555555',
      'Email' => 'test1@gmail.com'
    },
    'Items' => [
      {
        'SKU' => 'api_name',
        'ShipType' => 'Standard',
        'Images' => [
          {
            'Url' => '',
            'Index' => 1,
            'SpaceId' => ''
          }
        ],

      }
    ]
  }
end
