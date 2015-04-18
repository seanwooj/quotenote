require 'test_helper'

class UserTest < MiniTest::Test
  def test_validity
    user = build(:user)
    assert_equal true, user.valid?

    admin = build(:admin)
    assert_equal true, admin.valid?
  end


end
