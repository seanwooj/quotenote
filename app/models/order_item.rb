class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :quote_note

  validates_presence_of :product
  validates_presence_of :quote_note

  def total_price
    product.price * quantity
  end
end
