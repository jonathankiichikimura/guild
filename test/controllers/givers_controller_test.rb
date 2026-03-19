require "test_helper"

class GiversControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get givers_show_url
    assert_response :success
  end
end
