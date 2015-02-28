# == Schema Information
#
# Table name: backgrounds
#
#  id                 :integer          not null, primary key
#  repeating          :boolean
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

class Background < ActiveRecord::Base
  has_attached_file :image,
    :styles => {
      :small => '350x'
    },
    :convert_options => {
      :small => "-strip"
    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


end
