require "test_helper"

class GiverTest < ActiveSupport::TestCase
  test "valid with required attributes" do
    giver = Giver.new(first_name: "Haruko", email: "haruko@example.com", password: "password123")
    assert giver.valid?
  end

  test "invalid without first_name" do
    giver = Giver.new(email: "haruko@example.com", password: "password123")
    assert_not giver.valid?
  end

  test "invalid without email" do
    giver = Giver.new(first_name: "Haruko", password: "password123")
    assert_not giver.valid?
  end

  test "display_name returns first_name when present" do
    giver = Giver.new(first_name: "Haruko", email: "haruko@example.com", password: "password123")
    assert_equal "Haruko", giver.display_name
  end
end
