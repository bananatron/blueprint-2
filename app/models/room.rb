class Room < ApplicationRecord
  belongs_to :session
  belongs_to :room_east, class_name: 'Room', optional: true
  belongs_to :room_west, class_name: 'Room', optional: true
  belongs_to :room_south, class_name: 'Room', optional: true
  belongs_to :room_north, class_name: 'Room', optional: true

  validates :width, presence: true
  validates :height, presence: true
  validates :width, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 20 }
  validates :height, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 20 }

  def object_serialize
    {
      id: id,
      width: width,
      height: height,
      # room_east_id: room_east_id,
      # room_west_id: room_west_id,
      # room_south_id: room_south_id,
      # room_north_id: room_north_id,
    }
  end
end
