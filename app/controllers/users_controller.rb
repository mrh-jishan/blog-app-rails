class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      json_response({user: @user, token: token})
    else
      json_response({error: @user.errors.full_messages},:bad_request)
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by_username(user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      json_response( {user: @user, token: token})
    else
      json_response( {error: "Invalid username or password"}, :unauthorized)
    end
  end

  def auto_login
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name)
  end
end
