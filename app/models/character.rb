class Character < ApplicationRecord
  has_many :loots
  belongs_to :user
  belongs_to :session
  belongs_to :room

  validates :name, presence: true
  validates :room, presence: true
  validates :role, presence: true
  validates :x, presence: true
  validates :y, presence: true
  validates :role, inclusion: { in: Schemas::CharacterRoles::DATA.keys.map(&:to_s) }

  def object_serialize
    {
      id: id,
      name: name,
      role: role,
      x: x,
      y: y,
      room_id: room_id,
      session_id: session_id,
      user_id: user_id,
      ready_to_start: ready_to_start?,
    }
  end

  def ready_to_start?
    ready_to_start_at.present?
  end
end
