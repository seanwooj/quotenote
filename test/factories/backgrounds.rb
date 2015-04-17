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
    
  end

end
