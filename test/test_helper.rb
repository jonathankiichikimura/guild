ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    def valid_giver_attrs(overrides = {})
      {
        first_name: "Test Giver",
        email: "giver@example.com",
        password: "password123",
        suburb: "shinjuku",
        emergency_contact_name: "Test Contact",
        emergency_contact_phone: "090-0000-0000"
      }.merge(overrides)
    end

    def valid_accepter_attrs(overrides = {})
      {
        full_name: "Test Accepter",
        email: "accepter@example.com",
        password: "password123",
        suburb: "shinjuku"
      }.merge(overrides)
    end
  end
end
