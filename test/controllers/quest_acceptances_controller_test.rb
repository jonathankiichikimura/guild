require "test_helper"

class QuestAcceptancesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get quest_acceptances_create_url
    assert_response :success
  end

  test "should get destroy" do
    get quest_acceptances_destroy_url
    assert_response :success
  end
end
