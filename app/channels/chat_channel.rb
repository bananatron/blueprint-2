class ChatChannel < ApplicationCable::Channel
  def subscribed
    # if params.dig('channel_name').include?('user_id') && params.dig('channel_name').split(':').last != current_user.id
      # raise Errors::FishyError, "NOT subscribed to the right user_id" if params.dig('channel_name').split(':').last != current_user.id
    # end

    stream_from "chat_channel##{params.dig('channel_name')}"
  end

  def unsubscribed
    # TODO this can be used for logout??
    puts "Unsubscribed from #{params.dig('channel_name')}"
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    raise "No cu rrent_user" unless current_user

    service = Chat::PlayerMessageService.new(
      user: current_user,
      unit: current_user.current_unit,
      body: data.dig('body'),
      channel: data.dig('channel'),
    )

    service.call
  end
end
