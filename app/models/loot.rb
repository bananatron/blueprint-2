class Loot < ApplicationRecord
  belongs_to :character, optional: true
  belongs_to :room, optional: true

  validate :valid_room_or_character
  validate :valid_room_coords

  def pick_up(character:)
    update!(
      character: character,
      room_id: nil,
      x: nil,
      y: nil,
    )
  end

  private

  def valid_room_coords
    return if room.blank?

    if room.width < x
      errors.add(:x, "can't be greater than room width")
    end

    if room.height < y
      errors.add(:y, "can't be greater than room height")
    end
  end

  def valid_room_or_character
    if character.present? && room.present?
      errors.add(:base, "Loot can't have both character and room")
    end

    if character.blank? && room.blank?
      errors.add(:base, "Loot must have either character or room")
    end
  end
end
