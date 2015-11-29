class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin_user
    # redirect_to root_path, notice: '権限エラー' unless current_user && current_user.admin?
  end

  # cancancanでaccess_deniedされた時の挙動を記述
  def access_denied(exception)
    # Rails.logger.error "access denied! '#{exception.message}'"
    redirect_to root_path, notice: 'aaa'
  end
end
