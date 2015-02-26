class AddImageColumnsToBackgrounds < ActiveRecord::Migration
  def self.up
    add_attachment :backgrounds, :image
  end

  def self.down
    remove_attachment :backgrounds, :image
  end
end
