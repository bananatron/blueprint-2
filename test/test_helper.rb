ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase

    setup do
      if Rails.env.test?
        Redis.new(url: "redis://localhost:6379/1").flushdb
      end
    end

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def sign_in(user)
      post user_session_url, params: { user: { email: user.email, password: 'password' } }
      follow_redirect!
    end
  end
end
