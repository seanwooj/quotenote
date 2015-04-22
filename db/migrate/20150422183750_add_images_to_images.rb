class AddImagesToImages < ActiveRecord::Migration
  def change
    add_attachment :images, :images
  end
end
