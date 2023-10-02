# frozen_string_literal: true

# base controller class from which other controller classes inhert from
# right now it contains sessions authentication logic will delete later also contains pundit authorizations
class ApplicationController < ActionController::Base
  before_action :set_current_user
  # include Pundit
  include Pundit::Authorization

  def set_current_user
    return unless session[:user_id]

    Current.user = User.find_by(id: session[:user_id])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def require_user_logged_in!
    redirect_to signin_path, alert: 'you must be signed in to do that' if Current.user.nil?
  end

  # handle error from pundit if user not authorized
  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(root_path)
  end
end
