class AddAssociationsToImage < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.references :imageable, :polymorphic => true, :index => true
    end
  end
end
