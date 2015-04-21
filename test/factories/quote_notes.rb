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

FactoryGirl.define do
  factory :quote_note do
  quote_text "MyText about something cool"
  font_family "cabin_sketch"
  quote_author "Author"
  background
  overlay true
  font_color "#ffffff"
  end

end
