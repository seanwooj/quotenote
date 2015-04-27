# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  price       :decimal(, )
#  name        :string
#  api_name    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Product < ActiveRecord::Base
  validates_presence_of :name, :price, :api_name, :height, :width
  validates_numericality_of :price

  has_many :images, :as => :imageable

  def height_string
    self.height.to_s + 'px'
  end

  def width_string
    self.width.to_s + 'px'
  end
end
