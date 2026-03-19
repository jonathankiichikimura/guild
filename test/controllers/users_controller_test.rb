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

class AcceptersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

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
  end

  test "should get accepter show" do
    skip "AcceptersController#show not yet implemented"
  end
end
