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

class Background < ActiveRecord::Base
  has_attached_file :image,
    :styles => {
      :small => '1000x',
      :thumb => '150x'
    },
    :convert_options => {
      :small => "-strip"
    }

  scope :global, -> { where(:global => true) }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :image, :name

  belongs_to :user

  def self.available_for_user(current_user = nil, session_id = nil)
    if current_user
      Background.global | Background.where(:user => current_user)
    elsif session_id
      Background.global | Background.where(:session_id => session_id)
    else
      Background.global
    end
  end

  def self.generate_unique_name(current_user = nil, session_id = nil)
    strtime = Time.now.strftime('%s')
    if current_user
      email = current_user.email
      name = email[/[^@]+/]
      name + strtime
    elsif session_id
      session_id + strtime
    else
      (0...8).map { (65 + rand(26)).chr }.join + strtime
    end
  end
end
