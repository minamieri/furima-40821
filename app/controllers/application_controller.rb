class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :email, :password, :password_confirmation, :birthday, :full_width_lastname, :full_width_firstname,
                                             :katakana_lastname, :katakana_firstname])
  end
end
