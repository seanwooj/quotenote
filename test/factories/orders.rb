FactoryGirl.define do
  factory :order do
    association :user, :factory => :user_with_all_fields
  end

end
