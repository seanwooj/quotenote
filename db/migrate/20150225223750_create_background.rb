class CreateBackground < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.boolean :repeating
      t.text :name
      t.text :source_url
      t.text :creator
      t.text :license_type
      t.timestamps
    end
  end
end
