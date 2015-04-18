class AddGlobalFlagToBackgrounds < ActiveRecord::Migration
  def change
    add_column :backgrounds, :global, :boolean
  end
end
