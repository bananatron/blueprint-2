
class SessionChannel < ApplicationCable::Channel
  def subscribed
    session = Session.find_by(id: params[:id])
    raise "no session found for id #{params[:id]}" unless session

    transmit(session.object_serialize)

    stream_from "session_channel#{params[:id]}"
  end

  def unsubscribed
    # TODO hide user from zone when someone logs out / unsubscribes??
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    raise 'SessionChannel receive lol!'
  end
end
