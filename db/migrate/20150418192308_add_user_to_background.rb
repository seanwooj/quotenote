class AddUserToBackground < ActiveRecord::Migration
  def change
    add_reference :backgrounds, :user, index: true
    add_foreign_key :backgrounds, :users
  end
end
