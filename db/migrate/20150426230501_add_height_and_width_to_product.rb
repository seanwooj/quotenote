class AddHeightAndWidthToProduct < ActiveRecord::Migration
  def change
    add_column :products, :height, :integer
    add_column :products, :width, :integer
  end
end
