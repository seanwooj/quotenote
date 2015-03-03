class DefaultRepeatingToFalse < ActiveRecord::Migration
  def change
    change_column_default :backgrounds, :repeating, false
  end
end
