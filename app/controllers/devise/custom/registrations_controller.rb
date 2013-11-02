class Devise::Custom::RegistrationsController < Devise::RegistrationsController
  def new
    super # no customization, simply call the devise implementation
    params.inspect
  end

  def create
    @username  = params[:username_prefix] + params[:username_suffix]
    # if either throw bad
    params[:user][:username] = @username
    
    case params[:season]
    when "Spring" 
      puts " -- spring"
      params[:user]["birthday(2i)"] = "3"
      params[:user]["birthday(3i)"] = "21"
    when "Summer"
      puts "  --- summer"
      params[:user]["birthday(2i)"] = "6"
      params[:user]["birthday(3i)"] = "21"
    when "Autumn"
      params[:user]["birthday(2i)"] = "9"
      params[:user]["birthday(3i)"] = "21"
    when "Winter"
      params[:user]["birthday(2i)"] = "12"
      params[:user]["birthday(3i)"] = "21"
    else
      # throw bad
    end

    # need to check if year not saved
    params[:user]["birthday(1i)"] = params[:date][:birth_year]

    # puts ''
    # puts "  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   "
    #  params.inspect
    #  puts ""
    #  puts params[:user].inspect
    #  puts @username.inspect
    #  puts params[:user][:username]

    #  puts ''

    super
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