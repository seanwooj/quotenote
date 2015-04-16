class Cart
  attr_reader :items

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



end
