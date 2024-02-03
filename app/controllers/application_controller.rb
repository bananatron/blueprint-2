class ApplicationController < ActionController::Base
  helper_method :current_character

  def current_character
    @current_character ||= current_user.current_character if user_signed_in?
  end

  private

  def redirect_authenticate
    return if current_user.blank?

    redirect_to game_show_path
  end
end
