require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @giver = Giver.create!(valid_giver_attrs)
    @quest = Quest.create!(
      title: "Test Quest",
      description: "A test quest description",
      giver: @giver
    )
  end

  test "should get new" do
    skip "ReviewsController#new not yet implemented"
  end

  test "should create review" do
    skip "ReviewsController#create not yet implemented"
  end
end
