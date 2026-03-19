require "test_helper"

class QuestApplicationTest < ActiveSupport::TestCase
  setup do
    @giver = Giver.create!(
      first_name: "Test Giver",
      email: "giver@example.com",
      password: "password123",
      suburb: "Shinjuku"
    )
    @accepter = Accepter.create!(
      full_name: "Test Accepter",
      email: "accepter@example.com",
      password: "password123"
    )
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
