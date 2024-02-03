module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    rescue_from StandardError, with: :report_error

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.id
    end

    protected

    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def report_error(error)
      # return if rand(10) > 5 # To remove error count
      Sentry.capture_message("ApplicationCable#report_error current_user:#{current_user.try(:id)}, #{error}")
    end
  end
end
