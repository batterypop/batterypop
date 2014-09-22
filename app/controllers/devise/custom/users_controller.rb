class Devise::Custom::UsersController< Devise::SessionsController 
  
  prepend_before_filter :require_no_authentication, :only => [ :new, :create, :update ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  prepend_before_filter { request.env["devise.skip_timeout"] = true }

  # GET /resource/sign_in
  def new
    super
    # self.resource = resource_class.new(sign_in_params)
    # clean_up_passwords(resource)
    # respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    # ga('send', 'event', 'category', 'action', {'nonInteraction': 1});
    # ga_push("_addItem", "ID", "SKU")
    # ga_track_event("Users", "Login", "Standard")
    super
    # ga_push("_addItem", "&uid’", resource.id)
    # ga_track_event("Users", "Login", resource.username, resource.id)
    # ga_track_event("Users", "Login", {nonInteraction: 1, username: resource.username, id: resource.id}.to_json)
    
    # self.resource = warden.authenticate!(auth_options)
    # set_flash_message(:notice, :signed_in) if is_navigational_format?
    # sign_in(resource_name, resource)
    # respond_with resource, :location => after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    super
    # redirect_path = after_sign_out_path_for(resource_name)
    # signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # # We actually need to hardcode this as Rails default responder doesn't
    # # support returning empty response on GET request
    # respond_to do |format|
    #   format.all { head :no_content }
    #   format.any(*navigational_formats) { redirect_to redirect_path }
    # end
  end

  protected

  # def sign_in_params
  #   devise_parameter_sanitizer.sanitize(:sign_in)
  # end

  # def serialize_options(resource)
  #   methods = resource_class.authentication_keys.dup
  #   methods = methods.keys if methods.is_a?(Hash)
  #   methods << :password if resource.respond_to?(:password)
  #   { :methods => methods, :only => [:password] }
  # end

  # def auth_options
  #   { :scope => resource_name, :recall => "#{controller_path}#new" }
  # end
end
