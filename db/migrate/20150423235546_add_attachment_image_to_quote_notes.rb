class AddAttachmentImageToQuoteNotes < ActiveRecord::Migration
  def self.up
    change_table :quote_notes do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :quote_notes, :image
  end
end
