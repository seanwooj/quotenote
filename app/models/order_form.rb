class OrderForm
  include ActiveModel::Model

  attr_accessor :user, :order, :cart

  def save
    if valid?
      persist
      true
    else
      false
    end
  end

  private

  def persist
    user.save!
    @order = Order.create! :user => user

    build_order_items
  end

  def valid?
    user.valid?
  end

  def build_order_items
    cart.items.each do |item|
      @order.order_items.create! :product_id => item.product_id, :quote_note_id => item.quote_note_id, :quantity => item.quantity
    end
  end

end
