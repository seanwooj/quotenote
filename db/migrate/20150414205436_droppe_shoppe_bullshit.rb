class DroppeShoppeBullshit < ActiveRecord::Migration
  def change
    drop_table :nifty_attachments
    drop_table :nifty_key_value_store
    drop_table :shoppe_countries
    drop_table :shoppe_delivery_service_prices
    drop_table :shoppe_delivery_services
    drop_table :shoppe_order_items
    drop_table :shoppe_orders
    drop_table :shoppe_payments
    drop_table :shoppe_product_attributes
    drop_table :shoppe_product_categories
    drop_table :shoppe_products
    drop_table :shoppe_settings
    drop_table :shoppe_stock_level_adjustments
    drop_table :shoppe_tax_rates
    drop_table :shoppe_users

  end
end
