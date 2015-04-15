class CreateQuoteNotes < ActiveRecord::Migration
  def change
    create_table :quote_notes do |t|
      t.text :quote_text
      t.string :font_family
      t.string :quote_author
      t.references :background, index: true
      t.boolean :overlay
      t.string :font_color

      t.timestamps null: false
    end
    add_foreign_key :quote_notes, :backgrounds
  end
end
