require 'test_helper'

class CartTest < MiniTest::Test
  def test_adds_one_item
    cart = Cart.new
    cart.add_item 1

    assert_equal cart.empty?, false
  end

  def adds_up_in_quanitity
    cart = Cart.new
    3.times { cart.add_item 1 }

    assert_equal cart.items.length, 1
    assert_equal cart.items
  end
end
