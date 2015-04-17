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
  validates_presence_of :name, :price, :api_name
  validates_numericality_of :price
end
