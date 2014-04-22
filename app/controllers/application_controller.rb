class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location
   before_action :getGACode




  def getGACode
    case Rails.env
      when 'production'
         @gacode = "UA-44486746-1"
       when 'staging'
         @gacode = "UA-44486746-2"
     end
   end

 
    

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        request.fullpath != "/creators/sign_in" &&
        request.fullpath != "/creators/sign_out" &&
        request.fullpath != "/dashboard" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end


  def after_sign_in_path_for(resource)
    if (resource.class.name == "Creator")
       session[:previous_url] = "/dashboard"
    elsif (resource.class.name == 'AdminUser')
       session[:previous_url] = "/admin"
     end
    session[:previous_url] || root_path
  end




  protected

  def devise_parameter_sanitizer
    if resource_class == User
      Devise::Custom::ParamaterSanitizer.new(User, :user, params)
    elsif resource_class == Creator
      Devise::Custom::CreatorSanitizer.new(Creator, :creator, params)
    else
      super # Use the default one
    end
  end


end