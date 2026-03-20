require "test_helper"

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
