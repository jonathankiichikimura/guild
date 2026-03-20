require "test_helper"

class GiversControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @giver = Giver.create!(valid_giver_attrs)
  end

  test "should get giver show" do
    skip "GiversController#show not yet implemented"
  end
end
