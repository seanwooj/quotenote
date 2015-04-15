class Product < ActiveRecord::Base
  validates_presence_of :name, :price, :api_name
  validates_numericality_of :price
end
