require "test_helper"

class OrderItemTest < ActiveSupport::TestCase

  def order_item
    @order_item ||= OrderItem.new
  end

  def test_valid
    assert order_item.valid?
  end

end
