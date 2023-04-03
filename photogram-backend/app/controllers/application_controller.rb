class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action only: [:edit, :update, :destroy, :following, :followers]
  before_action :set_current_user
  #before_action :authorize

  def authorize
    @current_user = User.find_by(id: session[:user_id])
    render json: {error: ["Not authorized"]}, status: :unauthorized unless @current_user
  end

  private

  def set_current_user
    @current_user = @current_user
  end
end
