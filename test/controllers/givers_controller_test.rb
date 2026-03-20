require "test_helper"

class GiversControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @giver = Giver.create!(
      first_name: "Test Giver",
      email: "giver@example.com",
      password: "password123",
      suburb: "Shinjuku"
    )
  end

  test "should get giver show" do
    skip "GiversController#show not yet implemented"
  end
end
