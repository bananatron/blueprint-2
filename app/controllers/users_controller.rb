class UsersController < ApplicationController
  before_action :redirect_authenticate

  def start
  end

  def create
    user_params = params.require(:user).permit(:name, :email)

    builder = Builders::User.new
    builder.build(
      name: user_params[:name],
      email: user_params[:email]
    )

    if builder.record.valid?
      sign_in(builder.record)
      flash[:notice] = "User created and signed in successfully"
      redirect_to game_show_path
    else
      flash[:error] = builder.errors.join(', ')
      redirect_to users_start_path
    end
  end
end
