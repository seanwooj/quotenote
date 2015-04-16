class CartItem
  attr_reader :product_id, :quote_note_id, :quantity

  def initialize product_id, quote_note_id, quantity = 1
    @product_id = product_id
    @quote_note_id = quote_note_id
    @quantity = quantity
  end

  def increment
    @quantity += 1
  end

  def decrement
    unless @quantity <= 0
      @quantity -= 1
    else
      @quantity = 0
    end
    @quantity
  end

  def product
    Product.find(@product_id)
  end

  def quote_note
    QuoteNote.find(@quote_note_id)
  end

  def total_price
    quantity * product.price
  end
end
