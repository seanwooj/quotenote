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

FactoryGirl.define do
  factory :product do
    name "name"
    price 1.5
    api_name "api_name"
  end

end
