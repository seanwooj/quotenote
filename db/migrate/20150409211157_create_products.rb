class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :price
      t.string :name
      t.string :api_name

      t.timestamps null: false
    end
  end
end
