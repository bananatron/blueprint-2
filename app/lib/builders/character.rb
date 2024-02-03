class Builders::Character < Builders::Base
  def initialize
    super(Character)
  end

  def build(
    name:,
    user:,
    room: Room.global_starting_room,
    physical_description: 'Plain and unkept.',
    behavioral_description: 'Looking around confused.'
  )

    raise "No rooms to land on" if Room.count == 0

    @record.name = name
    @record.user = user
    @record.room = room
    @record.physical_description = physical_description
    @record.behavioral_description = behavioral_description
    @record.x = rand(room.width-1)+1 # Maybe not random location?
    @record.y = rand(room.height-1)+1 # Maybe not random location?

    unless @record.valid?
      @errors += @record.errors.full_messages
      return false
    end

    ActiveRecord::Base.transaction do
      @record.save!
    end

    begin
      ActiveRecord::Base.transaction do
        @record.save!
      end
    rescue ActiveRecord::RecordInvalid => error
      @errors << error.message
      return false
    end

  end
end
