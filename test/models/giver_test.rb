require "test_helper"

class GiverTest < ActiveSupport::TestCase
  VALID_ATTRS = {
    first_name: "Haruko",
    email: "haruko@example.com",
    password: "password123",
    suburb: "shinjuku",
    emergency_contact_name: "Keiko Tanaka",
    emergency_contact_phone: "090-1234-5678"
  }.freeze

  test "valid with required attributes" do
    giver = Giver.new(VALID_ATTRS)
    assert giver.valid?
  end

  test "invalid without first_name" do
    giver = Giver.new(VALID_ATTRS.except(:first_name))
    assert_not giver.valid?
  end

  test "invalid without email" do
    giver = Giver.new(VALID_ATTRS.except(:email))
    assert_not giver.valid?
  end

  test "invalid without suburb" do
    giver = Giver.new(VALID_ATTRS.except(:suburb))
    assert_not giver.valid?
  end

  test "invalid without emergency_contact_name" do
    giver = Giver.new(VALID_ATTRS.except(:emergency_contact_name))
    assert_not giver.valid?
  end

  test "invalid without emergency_contact_phone" do
    giver = Giver.new(VALID_ATTRS.except(:emergency_contact_phone))
    assert_not giver.valid?
  end

  test "display_name returns first_name when present" do
    giver = Giver.new(VALID_ATTRS)
    assert_equal "Haruko", giver.display_name
  end
end
