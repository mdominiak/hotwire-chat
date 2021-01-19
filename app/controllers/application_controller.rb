class ApplicationController < ActionController::Base
  before_action :authenticate_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id]) if session[:current_user_id]
  end
  helper_method :current_user

  def authenticate_user
    redirect_to root_url unless current_user
  end
end
