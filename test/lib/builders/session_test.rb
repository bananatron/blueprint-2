require "test_helper"

class Builders::SessionTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @builder = Builders::Session.new(host: @user)
  end

  def test_build
    @builder.build

    assert_not_nil @builder.instance
    assert_equal @user, @builder.instance.host

    assert_operator @builder.instance.rooms.count, :>=, 10
    assert_operator @builder.instance.rooms.count, :<=, 15

    @builder.instance.rooms.each do |room|
      assert room.room_east || room.room_west || room.room_south || room.room_north
    end
  end
end
