# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  address                :string
#  phone                  :string
#  postal_code            :string
#  country                :string
#  city                   :string
#  created_at             :datetime
#  updated_at             :datetime
#

FactoryGirl.define do
  factory :user do
    name "Test User"
    sequence(:email) { |n| "test#{n}@gmail.com" }
    admin false
    password 'password'

    factory :user_with_all_fields do
      address '123 test address'
      city 'Los Angeles'
      postal_code '94608'
      phone '5555555555'
      country 'US'
    end
  end

  factory :admin, :class => User do
    name "Test Admin"
    email "testadmin@gmail.com"
    admin true
    password 'password'
  end

end
