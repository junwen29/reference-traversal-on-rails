class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.admin?
  end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :bio]
      devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :bio, :avatar]
    end

end
