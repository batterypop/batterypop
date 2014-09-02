
module ApplicationHelper
  include DashboardUtility
  include ActsAsTaggableOn::TagsHelper
  # include Split::Helper



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

  def meta_description
    base_description = "Free videos for kids in a safe, super fun setting. Cartoons, comedy, music and more, and KIDS decide what pops!"
    if @description.nil? || @description.empty?
      base_description
    else
      strip_tags("#{@description}")
    end
  end


  def meta_keywords
    base_tags = "Kids, Videos, Cartoons, Music, Funny, Safe, Comedy, Shows, Animation, Parents, Children, Web series, Webisodes, Kids Videos, Videos for Kids, Kid Safe Videos"
    if @page_keywords.nil?
      base_tags
    else
      "#{@page_keywords}, #{base_tags}"
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



    def get_ga_custom
      if @ga_custom.nil? || @ga_custom.empty?
        ""
      else
        return @ga_custom.html_safe
      end
    end


    def get_ga_page_params 
      if @ga_page_params.nil? || @ga_page_params.empty?
        ""
      else
        return @ga_page_params.html_safe
      end
    end

    def colors
     ["blue","purple","gold","orange","green","navy","red","mint"]
    end
    
    def get_avatars
      Avatar.all
    end

    def get_age_ranges
      return [
        'All Ages',
        '6+',
        '9+'
      ]
    end

    def custom_background_override
      if !@custom_background.nil?
      "<div class='bk-extra' style='background: url(#{@custom_background}) repeat left top;'></div>".html_safe
      else
        ""
      end
    end





  def chart_data_to_donut(arr)
    DashboardUtility.chart_data_to_donut(arr)
  end


  def chart_data_to_bar(arr)
    DashboardUtility.chart_data_to_bar(arr)
  end



  def traceout(object)
    puts ""
    puts ""
    puts " %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    TRACEOUT  %%%%%%%%%%%%%%%%%%%%%%%%%%"
    # ap object
    puts object.inspect
    puts " %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    TRACEOUT  %%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts ""
    puts ""
  end

# viddler helpers was originally it's own class
  
  def viddler_files(viddler_id, episode_id)
    # @viddler ||= Viddler::Client.new(viddler_id)
    @viddler = Viddler::Client.new(viddler_id)
    # traceout("instantiate viddler wtih #{viddler_id}")
    # puts @viddler.inspect
    @viddler.authenticate! ENV['VIDDLER_USER'], ENV['VIDDLER_PASSWORD']
    videoData = @viddler.get 'viddler.videos.getDetails', :video_id => "#{episode_id}"
    # traceout(videoData)
    return videoData
  end

  def vid_link_create(episode)
    if(episode.links.empty?)
      if(episode.embed.provider == 'viddler' ) # no links, need to create
          videoData = viddler_files(ENV['VIDDLER_ID'], episode.video)
          if videoData['video']['files'].nil?
            videoData = viddler_files(ENV['VIDDLER_SECOND_ID'], episode.video)
          end


          if !(videoData['video']['files'].nil?)
            files = ((videoData['video']['files'].each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by{|g| g['width'] }.reverse

            @poster = videoData['video']['thumbnail_url'].empty? ? "" : videoData['video']['thumbnail_url']

            files.each do |f|
              f['poster'] = @poster
              @link = Link.new(:url => f['html5_video_source'], :data => f.to_json, :linkedmedia => episode, :link_type => 'file' )
              @link.save
            end
          end
      end
    end
  end

  def vid_embed(episode)
   @ret = episode.embed.get_embed(episode.embed, episode.video).html_safe

    if (episode.links.empty?)
      traceout("YES #{episode.links.empty?}")
      if(episode.embed.provider == 'viddler' ) # no links, need to create
        
        vid_link_create(episode)

        # videoData = viddler_files(ENV['VIDDLER_ID'], episode.video)
       
        # if videoData['video']['files'].nil?
        #   videoData = viddler_files(ENV['VIDDLER_SECOND_ID'], episode.video)
        # end
          @ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
         # @src = ""
        # if videoData['video']['files'].nil?
          if episode.links.empty?
           old = Embed.where(:provider => "viddler_original").first
           @ret = old.get_embed(old, episode.video).html_safe
           return @ret
        else
          # files = ((videoData['video']['files'].each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by{|g| g['width'] }.reverse

          #  @poster = videoData['video']['thumbnail_url'].empty? ? "" : videoData['video']['thumbnail_url']

          # files.each do |f|
          #   f['poster'] = @poster
          #   @link = Link.new(:url => f['html5_video_source'], :data => f.to_json, :linkedmedia => episode, :link_type => 'file' )
          #   @link.save
          # end
        end
      else
         @ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
        # just in case there's other info
        @ret = @ret.gsub("%showepisode%", "#{episode.show.title}: #{episode.title}")
        return @ret
      end
    end
     return(print_embed(episode))
  end

  def print_embed(episode)
    @src = ''
    # assuming link_type='file' for now
    episode.links.each do |link|
      data = ActiveSupport::JSON.decode(link.data)
      @poster = data['poster']
      @src+= "<source src='/links/#{link.id}/file' type='#{data['type']}' />"
    end
    @ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
    @ret = @ret.gsub("{{poster}}", "poster='#{@poster}'")
    @ret = @ret.gsub("{{videosources}}", @src)
    @ret = @ret.gsub("%showepisode%", "#{episode.show.title}: #{episode.title}")
    return(@ret)
  end



	def vid_file(episode)
    vid_link_create(episode)
    return episode.links
	end


  # using helper method to determin path, get possible link / sidebar and display
  def draw_if_sidebar
    Link.sidebar_from_link(request.original_fullpath)
  end





    # determine if friend feature is first view of page
    def is_friend_return_view?
      @prevURL = session[:previous_url].nil? ? ""  : session[:previous_url].split('/')[0..2].join('/')
      @curURL = request.fullpath.split('/')[0..2].join('/')
      return ( @curURL == @prevURL)
      # return false
    end

end
