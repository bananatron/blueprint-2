class ChatMessage < ApplicationRecord
  belongs_to :character, optional: true
  belongs_to :user, optional: true

  validates :channel, presence: true
  validates :body, presence: true
  validate :valid_channel
  before_validation :strip_html, on: [:create]

  VALID_CHANNEL_PREFIXES = [
    'global',
    'user_id:',
    'room_id:',
  ]

  def object_serialize
    {
      id: id,
      channel: channel,
      body: body,
      character_name: character.try(:name),
    }
  end

  private

  def strip_html
    self.body = ActionView::Base.full_sanitizer.sanitize(body)
  end

  def valid_channel
    return if channel.blank?
    return if VALID_CHANNEL_PREFIXES.any?{ |prefix| channel.start_with?(prefix) }

    errors.add(:channel, "must include #{VALID_CHANNEL_PREFIXES.join(', ')}")
  end
end
