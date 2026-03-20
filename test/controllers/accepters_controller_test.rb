require "test_helper"

class AcceptersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @giver = Giver.create!(valid_giver_attrs)
    @accepter = Accepter.create!(valid_accepter_attrs)
  end

  test "should get accepter show" do
    skip "AcceptersController#show not yet implemented"
  end
end
