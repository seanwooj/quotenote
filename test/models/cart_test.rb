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

  def test_serialization
    cart = Cart.new
    2.times { cart.add_item(1,2) }
    cart.add_item(2,2)

    assert_equal session_hash["cart"], cart.serialize
  end

  def test_create_from_hash
    cart = Cart.create_from_hash session_hash

    assert_equal cart.items.count, 2
    assert_equal cart.total_count, 3

    assert_equal cart.items.first.product_id, 1
    assert_equal cart.items.first.quote_note_id, 2
    assert_equal cart.items.first.quantity, 2

    assert_equal cart.items.last.product_id, 2
    assert_equal cart.items.last.quote_note_id, 2
    assert_equal cart.items.last.quantity, 1
  end

  private

  def session_hash
    {
      "cart" => {
        "items" => [
          {
            "product_id" => 1,
            "quote_note_id" => 2,
            "quantity" => 2
          },
          {
            "product_id" => 2,
            "quote_note_id" => 2,
            "quantity" => 1
          }
        ]
      }
    }
  end
end
