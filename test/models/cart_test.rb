require 'test_helper'

class CartTest < MiniTest::Test
  def test_adds_one_item
    cart = Cart.new
    cart.add_item(1,2)

    assert_equal cart.empty?, false
  end

  def test_adds_multiple_items
    cart = Cart.new
    3.times { cart.add_item(1,2) }

    assert_equal(1, cart.item_count)
    assert_equal(3, cart.total_count)
  end

  def test_object_retreival
    cart = Cart.new
    product = Product.create(:name => 'prod1', :api_name => 'api_prod1', :price => 5.0)
    qn = QuoteNote.create() # need to add attributes once I begin to validate the model

    cart.add_item(product.id, qn.id)
    assert_equal(product, cart.items.first.product)
    assert_equal(qn, cart.items.first.quote_note)
  end

  def test_pricing_calculations
    cart = Cart.new
    product = Product.create(:name => 'prod1', :api_name => 'api_prod1', :price => 5.0)
    product2 = Product.create(:name => 'prod1', :api_name => 'api_prod2', :price => 10.0)
    qn = QuoteNote.create() # need to add attributes once I begin to validate the model

    3.times { cart.add_item(product.id, qn.id) }
    cart.add_item(product2.id, qn.id)

    assert_equal 25.0, cart.total_price
    assert_equal 15.0, cart.items.first.total_price
    assert_equal 10.0, cart.items.last.total_price
  end
end
