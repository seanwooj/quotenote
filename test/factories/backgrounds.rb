# == Schema Information
#
# Table name: backgrounds
#
#  id                 :integer          not null, primary key
#  repeating          :boolean          default(FALSE)
#  name               :text
#  source_url         :text
#  creator            :text
#  license_type       :text
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

FactoryGirl.define do
  factory :background do
    image File.open("test/support/test_photo.jpg")

    factory :background_with_user do
      association :user, :factory => :user
    end

    factory :global_background do
      global true
    end

    factory :background_with_session_id do
      session_id 'seSs10nid'
    end
  end

end
