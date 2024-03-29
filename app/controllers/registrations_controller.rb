class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected 
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u| 
			u.permit(:first_name ,:last_name, :password, :password_confirmation, :email)
		end
  end
end
