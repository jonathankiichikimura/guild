require "test_helper"

class QuestApplicationTest < ActiveSupport::TestCase
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
    application = QuestApplication.new(quest: @quest, accepter: @accepter)
    assert application.valid?
  end

  test "defaults to pending status" do
    application = QuestApplication.create!(quest: @quest, accepter: @accepter)
    assert_equal "pending", application.status
  end
end
