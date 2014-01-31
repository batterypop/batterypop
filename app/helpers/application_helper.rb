module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper


  def link_helper(obj)
    return  pluralize(2, obj.class.name.downcase) + "/LINK_HELPER"
  end

  def title 
    base_title = "batteryPOP"
    if @title.nil?
      base_title
    else
      strip_tags("#{base_title} | #{@title}")
    end
  end

  def meta_keywords
    base_tags = "Kids, Videos, Cartoons, Music, Funny, Safe, Comedy, Shows, Animation, Parents, Children, Web series, Webisodes, Kids Videos, Videos for Kids, Kid Safe Videos"
    if @page_keywords.nil?
      base_tags
    else
      "#{base_tags}, #{@page_keywords}"
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

    def colors
     ["aqua","purple","gold","orangered","green","steelblue","red","mint"]
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
