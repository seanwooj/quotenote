require "test_helper"

class OrderTest < ActiveSupport::TestCase

  def order
    @order ||= create(:order)
  end

  def test_valid
    assert order.valid?
  end

end
