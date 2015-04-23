class CreateOrderStatusTransitions < ActiveRecord::Migration
  def change
    create_table :order_status_transitions do |t|
      t.references :order, index: true
      t.string :namespace
      t.string :event
      t.string :from
      t.string :to
      t.timestamp :created_at
    end
    add_foreign_key :order_status_transitions, :orders
  end
end
