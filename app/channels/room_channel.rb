class RoomChannel < ApplicationCable::Channel
  def subscribed
    # if current_unit.zone_id != params.dig('zone_id')
    #   Sentry.capture_message("FISHY unit_id:#{current_unit.id} trying to listen to zone they are not in")
    #   reject
    # end

    room_id = params['room_id']
    transmit(Room.find(room_id).object_serialize)
    stream_from "room_channel##{room_id}"
  end

  def unsubscribed
    # TODO hide user from zone when someone logs out / unsubscribes??
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # Should not happen
    return false
  end
end
