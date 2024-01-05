class StaticController < ApplicationController
  before_action :redirect_authenticate

  def index
  end

  private

  def redirect_authenticate
    return if current_user.blank?

    redirect_to game_join_path
  end
end
