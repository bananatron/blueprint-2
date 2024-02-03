class GameController < ApplicationController
  before_action :authenticate_user!

  def join
  end

  def show
    @session = Session.find(params[:session_id])
  end

  def join_game
    params[:invite_code]
    session = Session.find_by(invite_code: params[:invite_code])

    if session.nil?
      flash[:alert] = "Invalid invite code"
      return redirect_to game_join_path
    end

    if session.started?
      flash[:alert] = "Game already started"
      return redirect_to game_join_path
    end

    redirect_to game_show_path(session_id: session.id)
  end
end
