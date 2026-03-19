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

class AccepterTest < ActiveSupport::TestCase
  test "valid with required attributes" do
    accepter = Accepter.new(full_name: "Ren Kobayashi", email: "ren@example.com", password: "password123")
    assert accepter.valid?
  end

  test "invalid without email" do
    accepter = Accepter.new(full_name: "Ren Kobayashi", password: "password123")
    assert_not accepter.valid?
  end

  test "display_name returns full_name when present" do
    accepter = Accepter.new(full_name: "Ren Kobayashi", email: "ren@example.com", password: "password123")
    assert_equal "Ren Kobayashi", accepter.display_name
  end
end
