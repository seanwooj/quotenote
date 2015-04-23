class OrderStatusTransition < ActiveRecord::Base
  belongs_to :order
end
