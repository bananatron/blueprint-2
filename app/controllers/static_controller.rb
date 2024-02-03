class StaticController < ApplicationController
  before_action :redirect_authenticate

  def index
  end
end
