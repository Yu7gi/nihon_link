class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, if: :public_controller?
  before_action :authenticate_admin!, if: :admin_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :native])
  end

  private

  def authenticate_admin!
    return if request.path == new_admin_session_path
    unless admin_signed_in?
      flash[:alert] = "管理者としてログインしてください / Please log in as an administrator."
      redirect_to main_app.new_admin_session_path
    end
  end

  def public_controller?
    controller_path.start_with?('public/')
  end

  def admin_controller?
    controller_path.start_with?('admin/')
  end
end
