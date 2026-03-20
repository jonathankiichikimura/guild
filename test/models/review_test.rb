require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  setup do
    @giver = Giver.create!(valid_giver_attrs)
    @accepter = Accepter.create!(valid_accepter_attrs)
    @quest = Quest.create!(
      title: "Test Quest",
      description: "A test quest description",
      giver: @giver
    )
  end

  test "valid with required attributes" do
    review = Review.new(quest: @quest, giver: @giver, accepter: @accepter, rating: 5)
    assert review.valid?
  end

  test "invalid without rating" do
    review = Review.new(quest: @quest, giver: @giver, accepter: @accepter)
    assert_not review.valid?
  end

  test "invalid with rating below 1" do
    review = Review.new(quest: @quest, giver: @giver, accepter: @accepter, rating: 0)
    assert_not review.valid?
  end

  test "invalid with rating above 5" do
    review = Review.new(quest: @quest, giver: @giver, accepter: @accepter, rating: 6)
    assert_not review.valid?
  end
end
