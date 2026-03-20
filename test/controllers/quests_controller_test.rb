require "test_helper"

class QuestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @giver = Giver.create!(
      first_name: "Test Giver",
      email: "giver@example.com",
      password: "password123",
      suburb: "shinjuku"
    )
    @other_giver = Giver.create!(
      first_name: "Other Giver",
      email: "other_giver@example.com",
      password: "password123",
      suburb: "shibuya"
    )
    @accepter = Accepter.create!(
      full_name: "Test Accepter",
      email: "accepter@example.com",
      password: "password123",
      suburb: "shinjuku"
    )
    @quest = Quest.create!(
      title: "Test Quest",
      description: "A test quest description",
      giver: @giver,
      suburb: "shinjuku",
      status: "open"
    )
    @other_quest = Quest.create!(
      title: "Other Giver Quest",
      description: "Belongs to someone else",
      giver: @other_giver,
      suburb: "shibuya",
      status: "open"
    )
    @different_suburb_quest = Quest.create!(
      title: "Different Suburb Quest",
      description: "Open quest in a different ward",
      giver: @other_giver,
      suburb: "meguro",
      status: "open"
    )
  end

  test "should get index when signed in" do
    sign_in @giver
    get quests_url
    assert_response :success
  end

  test "giver index only shows their own quests" do
    sign_in @giver
    get quests_url
    assert_match @quest.title, response.body
    assert_no_match @other_quest.title, response.body
  end

  test "accepter index only shows open quests in their ward" do
    sign_in @accepter
    get quests_url
    assert_match @quest.title, response.body
    assert_no_match @different_suburb_quest.title, response.body
  end

  test "accepter index does not show non-open quests in their ward" do
    @quest.update!(status: "in_progress")
    sign_in @accepter
    get quests_url
    assert_no_match @quest.title, response.body
  end

  test "should redirect landing page when signed out" do
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
          suburb: "shibuya",
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
