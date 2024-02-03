class WorldBuilder
  def self.call
    Room.create!(
      width: 10,
      height: 10,
      name: 'Starting Room',
      description: 'A room with a single door to the north.',
    )
  end
end
