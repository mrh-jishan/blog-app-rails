class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorized

  WillPaginate.per_page = 10

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by_id(user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: {message: 'Please log in'}, status: :unauthorized unless logged_in?
  end

  def routing_error(error = 'Routing error', status = :not_found, exception = nil)
    render :json => 'Routing Error', :status => 401
  end
end
