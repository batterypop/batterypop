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

    def custom_background_override
      if !@custom_background.nil?
      "<div class='bk-extra' style='background: url(#{@custom_background}) repeat left top;
 width: 200%;height:999em;display:block;top:0;left:-50%;position:absolute;z-index: 0;'></div>".html_safe
      else
        ""
      end
    end


    # viddler authentication in one area
    def episode_embed_helper(episode)
     # right now videojs is only for viddler; otherwaise standard
        @ret = ''
        if(episode.embed.provider == 'viddler')
          @viddler = Viddler::Client.new(ENV['VIDDLER_ID'])
          @viddler.authenticate! ENV['VIDDLER_USER'], ENV['VIDDLER_PASSWORD']
           @ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
        else
          @ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
        end
        return @ret
    end




    # determine if friend feature is first view of page
    def is_friend_return_view?
      @prevURL = session[:previous_url].nil? ? ""  : session[:previous_url].split('/')[0..2].join('/')
      @curURL = request.fullpath.split('/')[0..2].join('/')
      return ( @curURL == @prevURL)
    end

end
