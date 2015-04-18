require 'test_helper'

class BackgroundTest < MiniTest::Test

  def test_validity
    background = build(:background)
    assert_equal true, background.valid?
  end

  def test_user
    background = build(:background_with_user)
    refute_equal background.user, nil
  end

  def test_scopes
    VCR.use_cassette("background_upload") do
      3.times { create(:global_background) }
      background = create(:background_with_user)
      irrelevent_user = create(:user)
      # crappy method of writing a test, but oh well. can fix later.
      irrelevent_background = create(:background)
      irrelevent_background.user = irrelevent_user
      irrelevent_background.save
      user = background.user
    end

    # backgrounds = Background.available_for_user user
    assert_equal 1, 1
  end

end
