class AddSessionIdToQuoteNote < ActiveRecord::Migration
  def change
    add_column :quote_notes, :session_id, :string
  end
end
