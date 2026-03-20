require "test_helper"

class QuestTest < ActiveSupport::TestCase
  setup do
    @giver = Giver.create!(valid_giver_attrs)
  end

  test "valid with required attributes" do
    quest = Quest.new(title: "Help needed", description: "Please help", giver: @giver)
    assert quest.valid?
  end

  test "invalid without title" do
    quest = Quest.new(description: "Please help", giver: @giver)
    assert_not quest.valid?
  end

  test "invalid without description" do
    quest = Quest.new(title: "Help needed", giver: @giver)
    assert_not quest.valid?
  end

  test "invalid with unrecognised status" do
    quest = Quest.new(title: "Help needed", description: "Please help", giver: @giver, status: "bogus")
    assert_not quest.valid?
  end

  test "defaults to open status" do
    quest = Quest.create!(title: "Help needed", description: "Please help", giver: @giver)
    assert_equal "open", quest.status
  end
end
