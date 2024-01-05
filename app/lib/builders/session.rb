class Builders::Session
  attr_reader :instance, :errors

  def initialize(host:)
    @instance = nil
    @host = host
    @errors = []
  end

  def build
    @instance = Session.new(host: @host)
    begin
      ActiveRecord::Base.transaction do
        @instance.save!

        rooms = Array.new(rand(10..15)) do
          Room.create!(
            session: @instance,
            width: rand(5..20),
            height: rand(5..20),
          )
        end

        connect_rooms(rooms)
      end

      true
    rescue => error
      @errors << error.message

      false
    end
  end


  private

  def connect_rooms(rooms)
    # First, ensure each room has at least one connection
    rooms.each_with_index do |room, index|
      other_room = rooms[(index + 1) % rooms.size]
      room.update!(room_east: other_room)
      other_room.update!(room_west: room)
    end

    # Then, make additional random connections
    rooms.each do |room|
      available_rooms = rooms - [room, room.room_east, room.room_west]

      available_rooms.sample(rand(1..2)).each do |other_room|
        direction = %w[room_south room_north].sample
        inverse_direction = direction == 'room_south' ? 'room_north' : 'room_south'

        next if room.send(direction) || other_room.send(inverse_direction)

        room.update!(direction => other_room)
        other_room.update!(inverse_direction => room)
      end
    end
  end

end
