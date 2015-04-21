require 'test_helper'

describe PrintIOService do
  it 'points to the correct endpoint' do
    PrintIOService.base_uri.must_equal "http://staging.api.print.io/api/v/1/source/api"
  end

  it 'serializes the data in the correct format' do
    ps = PrintIOService.new(create(:order))
    ps.serialize_for_post.must_equal ''
  end

end

def serialized_data
  {

  }
end
