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

end
