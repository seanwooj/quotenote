require 'json'

class Cart
  attr_reader :items

  def self.create_from_hash hash
    if hash["cart"] && hash["cart"]["items"]
      items = hash["cart"]["items"].map do |item|
        CartItem.new(item["product_id"], item["quote_note_id"], item["quantity"])
      end
    else
      items = []
    end

    Cart.new items
  end

  def initialize items = []
    @items = items
  end

  def add_item product_id, quote_note_id
    existing_item = @items.find do |item|
      item.product_id == product_id && item.quote_note_id == quote_note_id
    end

    if existing_item
      existing_item.increment
    else
      @items << CartItem.new(product_id, quote_note_id)
    end
    @items
  end

  def empty?
    @items.empty?
  end

  def empty
    @items = []
  end

  def item_count
    # number of unique items in the items array
    @items.count
  end

  def total_count
    # number of total purchased items
    @items.inject(0) { |sum, item| sum + item.quantity }
  end

  def total_price
    @items.inject(0) { |sum, item| sum + item.total_price }
  end

  def serialize
    items = @items.map do |item|
      {
        "product_id" => item.product_id,
        "quote_note_id" => item.quote_note_id,
        "quantity" => item.quantity
      }
    end

    {
      "items" => items
    }
  end



end
