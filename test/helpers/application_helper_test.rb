require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "ruby on rails tutorial sample app", full_title
    assert_equal  "Help | ruby on rails tutorial sample app", full_title("Help")
  end
end