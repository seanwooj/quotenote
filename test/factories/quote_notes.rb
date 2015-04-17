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
    quote_text "MyText"
font_family "MyString"
quote_author "MyString"
background nil
overlay false
font_color "MyString"
  end

end
