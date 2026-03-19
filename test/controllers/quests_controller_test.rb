require "test_helper"

class QuestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @giver = Giver.create!(
      first_name: "Test Giver",
      email: "giver@example.com",
      password: "password123",
      suburb: "Shinjuku"
    )
    @quest = Quest.create!(
      title: "Test Quest",
      description: "A test quest description",
      giver: @giver
    )
  end

  test "should get index when signed in" do
    sign_in @giver
    get quests_url
    assert_response :success
  end

  test "should redirect index when signed out" do
    get quests_url
    assert_redirected_to root_path
  end

  test "should get show" do
    sign_in @giver
    get quest_url(@quest)
    assert_response :success
  end

  test "should get new" do
    sign_in @giver
    get new_quest_url
    assert_response :success
  end

  test "should create quest" do
    sign_in @giver
    assert_difference("Quest.count") do
      post quests_url, params: {
        quest: {
          title: "New Quest",
          description: "Quest description",
          category: "groceries",
          suburb: "Shibuya",
          reward_amount: 1000,
          reward_type: "yen"
        }
      }
    end
  end

  test "should update quest" do
    skip "QuestsController#update not yet implemented"
  end

  test "should destroy quest" do
    skip "QuestsController#destroy not yet implemented"
  end
end
