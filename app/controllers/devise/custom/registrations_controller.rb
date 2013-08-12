class Devise::Custom::RegistrationsController < Devise::RegistrationsController
  def new
    super # no customization, simply call the devise implementation
  end

  def create
    super
    puts "**** WE GOT HERE ****"
    # begin
    #   super # this calls Devise::RegistrationsController#create
    # rescue MyApp::Error => e
    #   e.errors.each { |error| resource.errors.add :base, error }
    #   clean_up_passwords(resource)
    #   respond_with_navigational(resource) { render_with_scope :new }
    # end
  end

  def update
    super # no customization, simply call the devise implementation 
  end

  protected

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end