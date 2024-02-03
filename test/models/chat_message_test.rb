require "test_helper"

class ChatMessageTest < ActiveSupport::TestCase
  setup do
    @chat_message = chat_messages(:one) # assuming you have a fixture named 'one'
  end

  test "should be valid" do
    assert @chat_message.valid?
  end

  test "channel should be present" do
    @chat_message.channel = nil
    assert_not @chat_message.valid?
    assert_equal ["can't be blank"], @chat_message.errors[:channel]
  end

  test "body should be present" do
    @chat_message.body = nil
    assert_not @chat_message.valid?
    assert_equal ["can't be blank"], @chat_message.errors[:body]
  end

  test "channel should be valid" do
    @chat_message.channel = "invalid_channel"
    assert_not @chat_message.valid?
  end

  test "object_serialize should return correct hash" do
    expected_hash = {
      id: @chat_message.id,
      channel: @chat_message.channel,
      body: @chat_message.body,
      character_name: @chat_message.character.try(:name),
    }
    assert_equal expected_hash, @chat_message.object_serialize
  end
end
