
class TestChannel < ApplicationCable::Channel
  def subscribed

    transmit('Hello from ActionCable!')

    stream_from "test_channel#{params[:id]}"
  end

  def unsubscribed
    # TODO hide user from zone when someone logs out / unsubscribes??
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    raise 'TestChannel receive lol!'
  end
end
