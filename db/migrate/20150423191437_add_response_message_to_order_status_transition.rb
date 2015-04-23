class AddResponseMessageToOrderStatusTransition < ActiveRecord::Migration
  def change
    add_column :order_status_transitions, :response_message, :text
  end
end
