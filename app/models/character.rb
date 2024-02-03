class Character < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :name, presence: true
  validates :x, presence: true
  validates :y, presence: true
  validates :physical_description, presence: true
  validates :behavioral_description, presence: true

  def object_serialize
    {
      id: id,
      name: name,
      physical_description: physical_description,
      behavioral_description: behavioral_description,
      x: x,
      y: y,
      room_id: room_id,
      user_id: user_id,
    }
  end
end
