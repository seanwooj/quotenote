require 'test_helper'

describe PrintIOService do
  it 'points to the correct endpoint' do
    PrintIOService.base_uri.must_equal "http://staging.api.print.io/api/v/1/source/api"
  end
end
