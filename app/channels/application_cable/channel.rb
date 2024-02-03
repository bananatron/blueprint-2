module ApplicationCable
  class Channel < ActionCable::Channel::Base

    def current_character # Might be able to memoize but be cautious
      Character.find_by(id: current_user.current_character_id)
    end
  end
end
