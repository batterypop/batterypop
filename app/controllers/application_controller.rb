class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location


  def most_popped
    #@most_popped  ||= Show.first
    @most_popped ||= "This is a test"
  end
helper_method :most_popped


    

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end


  def after_sign_in_path_for(resource)
    if (resource.class.name == 'AdminUser')
       session[:previous_url] = "/admin"
     end
    session[:previous_url] || root_path
  end



  protected

  def devise_parameter_sanitizer
    if resource_class == User
      Devise::Custom::ParamaterSanitizer.new(User, :user, params)
    else
      super # Use the default one
    end
  end


end