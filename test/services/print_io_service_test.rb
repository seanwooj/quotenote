require 'test_helper'

describe PrintIOService do
  it 'points to the correct endpoint' do
    PrintIOService.base_uri.must_equal "http://staging.api.print.io/api/v/1/source/api"
  end

  it 'serializes the data in the correct format' do
    VCR.insert_cassette('background', :record => :new_episodes)
    order = create(:order)
    order.order_items << create(:order_item)
    ps = PrintIOService.new(order)
    byebug
    ps.serialize_for_post.must_equal serialized_data
    VCR.eject_cassette
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
            'Url' => '/generator.jpg?background_id=1&font_color=%23ffffff&font_family=cabin_sketch&full_size=true&quote_author=Author&quote_text%5B%5D=MyText+about+something+cool&repeating=false'
          }
        ],

      }
    ],
    'SourceId' => '' #order id to correspond to qn
  }
end
