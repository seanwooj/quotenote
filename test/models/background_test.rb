require "test_helper"

class BackgroundTest < ActiveSupport::TestCase

  def background
    @background ||= Background.new
  end

  def test_valid
    assert background.valid?
  end

end
