class AddDefaultValueToQuoteNote < ActiveRecord::Migration
  def change
    change_column_default :quote_notes, :overlay, true
  end
end
