class AddPreviewImageToQuoteNotes < ActiveRecord::Migration
  def change
    add_attachment :quote_notes, :preview_image
  end
end
