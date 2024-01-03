require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "fixture is valid" do
    user = users(:one)
    assert user.valid?, user.errors.full_messages.inspect
  end
end
