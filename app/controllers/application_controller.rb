class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required
  add_flash_types :info, :error, :warning

  private

  def login_required
    unless current_user
      flash[:error] = "ログインしてください"
    redirect_to new_session_path
  end
end

  def logged_inuser
    unless logged_in?
      redirect_to tasks_path
   end
  end
end