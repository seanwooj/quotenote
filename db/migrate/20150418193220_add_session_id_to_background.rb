class AddSessionIdToBackground < ActiveRecord::Migration
  def change
    add_column :backgrounds, :session_id, :string
  end
end
