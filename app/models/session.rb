class Session < ApplicationRecord

  validates :invite_code, presence: true, uniqueness: true
  belongs_to :host, class_name: 'User', foreign_key: 'host_user_id'
  has_many :rooms
  has_many :characters

  before_validation :generate_invite_code, on: :create

  def object_serialize
    {
      id: id,
      available_character_roles: available_character_roles,
      invite_code: invite_code,
      started: started?,
      rooms: rooms.map(&:object_serialize),
      characters: characters.map(&:object_serialize),
      ready_to_start: ready_to_start?,
    }
  end

  def broadcast_schema
    [
      { channel: "session_channel##{id}", data: object_serialize },
    ]
  end

  def available_character_roles
    roles = Schemas::CharacterRoles::DATA.keys.map(&:to_s)
    roles - characters.all.pluck(:role).uniq
  end

  def to_param
    invite_code
  end

  def started?
    started_at.present?
  end

  def ready_to_start?
    return false if characters.empty?

    characters.length >= 3 && characters.map(&:ready_to_start?).all?
  end

  private

  def generate_invite_code
    return if invite_code.present?

    self.invite_code = SecureRandom.hex(3)
  end
end
