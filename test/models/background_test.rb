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

  def test_user_scope
    valid_backgrounds = []
    background = Background.new # simply saving a reference, will be reassigned outside of the following block

    VCR.use_cassette("background_upload", :match_requests_on => [:body]) do
      3.times { valid_backgrounds << create(:global_background) }
      background = create(:background_with_user)
      valid_backgrounds << background
      irrelevant_user = create(:user)
      irrelevant_background = create(:background)
      irrelevant_background.user = irrelevant_user
      irrelevant_background.save
    end

    user = background.user

    backgrounds = Background.available_for_user user
    assert_equal backgrounds.count, 4

    backgrounds.each do |background|
      assert_equal true, valid_backgrounds.include?(background)
    end

  end

  def test_session_scope
    valid_backgrounds = []
    background = Background.new

    VCR.use_cassette("background_upload", :match_requests_on => [:body]) do
      valid_backgrounds << create(:global_background)
      background = create(:background_with_session_id)
      valid_backgrounds << background
      irrelevant_background = build(:background)
      irrelevant_background.session_id = '1rrelevant'
      irrelevant_background.save
    end

    session_id = background.session_id

    backgrounds = Background.available_for_user(nil, session_id)
    assert_equal backgrounds.count, 2

    backgrounds.each do |background|
      assert_equal true, valid_backgrounds.include?(background)
    end
  end

end
