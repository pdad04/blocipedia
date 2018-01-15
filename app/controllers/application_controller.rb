class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # Redirect to Wiki's page after sign in
  def after_sign_in_path_for(resource)
    wikis_path
  end

  # Redirect back to signon page after signout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
