module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def title 
    base_title = "BatteryPop"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # helpers for devise sessions
    def resource_name
  		:user
  	end

  	def resource
  		@resource ||= User.new
  	end
  	def devise_mapping
  		@devise_mapping ||= Devise.mappings[:user]
  	end


    def get_avatars
      Avatar.all
    end

    def get_age_ranges
      return [
        'Under 6',
        '6-8',
        '9-11',
        '11+'
      ]
    end

end
