class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def most_popped
    @most_popped  ||= Show.first
  end
helper_method :most_popped


  protected

  def devise_parameter_sanitizer
    if resource_class == User
      Devise::Custom::ParamaterSanitizer.new(User, :user, params)
    else
      super # Use the default one
    end
  end


end
