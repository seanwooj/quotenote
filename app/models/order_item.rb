class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :quote_note
end
