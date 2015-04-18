class AddUserToQuoteNote < ActiveRecord::Migration
  def change
    add_reference :quote_notes, :user, index: true
    add_foreign_key :quote_notes, :users
  end
end
