class GameController < ApplicationController
  before_action :authenticate_user!

  def show
    # <3
  end
end
