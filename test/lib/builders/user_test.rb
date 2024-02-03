require "test_helper"

class Builders::UserTest < ActiveSupport::TestCase
  def setup
    @builder = Builders::User.new
  end

  def test_build_success
    result = @builder.build(
      name: "Test User",
      email: "test@example.com",
      password: "password",
      super_user: false
    )

    assert result, "Expected build to be successful"
    assert @builder.record.persisted?, "Expected user to be saved to database"
    assert_equal "Test User", @builder.record.name, "Expected user name to be set correctly"
    assert_equal "test@example.com", @builder.record.email, "Expected user email to be set correctly"

    # Add this line to check that a character is created
    assert @builder.record.current_character_id, "Expected a character to be created for the user"
  end

  def test_build_failure
    result = @builder.build(
      name: nil, # Invalid name
      email: "test@example.com",
      password: "password",
      super_user: false
    )

    refute result, "Expected build to fail"
    assert @builder.record.new_record?, "Expected user not to be saved to database"
    assert @builder.errors.any?, "Expected there to be errors"
  end
end
