require "test_helper"

class QuestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @giver = Giver.create!(valid_giver_attrs)
    @other_giver = Giver.create!(valid_giver_attrs(email: "other_giver@example.com", suburb: "shibuya"))
    @accepter = Accepter.create!(valid_accepter_attrs)
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

  test "accepter index renders React mount point" do
    sign_in @accepter
    get quests_url
    assert_select "div#root[data-quests]"
  end

  test "accepter index does not render legacy quest list markup" do
    sign_in @accepter
    get quests_url
    assert_select "ul.quest-list", count: 0
  end

  test "accepter index data-quests only contains open quests in their ward" do
    sign_in @accepter
    get quests_url
    assert_select "div#root[data-quests]" do |elements|
      quests = JSON.parse(elements.first["data-quests"])
      titles = quests.map { |q| q["title"] }
      assert_includes titles, @quest.title
      assert_not_includes titles, @different_suburb_quest.title
    end
  end

  test "accepter index data-quests excludes non-open quests" do
    @quest.update!(status: "in_progress")
    sign_in @accepter
    get quests_url
    assert_select "div#root[data-quests]" do |elements|
      quests = JSON.parse(elements.first["data-quests"])
      titles = quests.map { |q| q["title"] }
      assert_not_includes titles, @quest.title
    end
  end

  test "accepter index data-quests only exposes whitelisted fields" do
    sign_in @accepter
    get quests_url
    assert_select "div#root[data-quests]" do |elements|
      quests = JSON.parse(elements.first["data-quests"])
      quests.each do |q|
        assert_equal %w[id title description reward_amount suburb].sort, q.keys.sort
      end
    end
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
