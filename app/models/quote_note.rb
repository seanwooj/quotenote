# == Schema Information
#
# Table name: quote_notes
#
#  id            :integer          not null, primary key
#  quote_text    :text
#  font_family   :string
#  quote_author  :string
#  background_id :integer
#  overlay       :boolean          default(TRUE)
#  font_color    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class QuoteNote < ActiveRecord::Base
  belongs_to :background
  belongs_to :user

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_attached_file :preview_image
  validates_attachment_content_type :preview_image, :content_type => /\Aimage\/.*\Z/

  before_validation :build_preview_image

  def arrayified_quote_text
    quote_text == '' ? [''] : quote_text.split("\n")
  end

  def serialize_relevant
    hash = self.serializable_hash
    hash = hash.slice('quote_text', 'font_family', 'quote_author', 'background_id', 'font_color', 'overlay')
  end

  def serialize_relevant_with_indifferent_access
    HashWithIndifferentAccess.new(serialize_relevant)
  end

  def serialize_for_client
    hash = serialize_relevant

    hash["quote_text"] = arrayified_quote_text

    # if for whatever reason background isn't set, set some defaults.
    # this should be removed later on.
    hash["repeating"] = (background.nil? ? false : background.repeating)
    hash["background_id"] = (background.nil? ? 3 : background.id)
    hash
  end

  def serialize_for_client_json
    serialize_for_client.to_json
  end

  def full_size_image_url
    hash = serialize_for_client
    hash["full_size"] = true
    "/generator.jpg?" + hash.to_query
  end

  def build_preview_image
    self.preview_image = Generator.generate_image_file self
  end
end
