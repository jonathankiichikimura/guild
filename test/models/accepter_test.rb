require "test_helper"

class AccepterTest < ActiveSupport::TestCase
  VALID_ATTRS = {
    full_name: "Ren Kobayashi",
    email: "ren@example.com",
    password: "password123",
    suburb: "shinjuku"
  }.freeze

  test "valid with required attributes" do
    accepter = Accepter.new(VALID_ATTRS)
    assert accepter.valid?
  end

  test "invalid without email" do
    accepter = Accepter.new(VALID_ATTRS.except(:email))
    assert_not accepter.valid?
  end

  test "invalid without suburb" do
    accepter = Accepter.new(VALID_ATTRS.except(:suburb))
    assert_not accepter.valid?
  end

  test "display_name returns full_name when present" do
    accepter = Accepter.new(VALID_ATTRS)
    assert_equal "Ren Kobayashi", accepter.display_name
  end
end
