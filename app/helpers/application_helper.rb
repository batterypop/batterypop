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

    def colors
     ["aqua","purple","gold","orangered","green","steelblue","red","mint"]
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
      "<div class='bk-extra' style='background: url(#{@custom_background}) repeat left top;
 width: 200%;height:999em;display:block;top:0;left:-50%;position:absolute;z-index: 0;'></div>".html_safe
      else
        ""
      end
    end



  def users_to_census_age_array(arr, deductYears=false)
    ret = Hash.new
    arr.each do |user|
      # ret << user.id
      # targetDate = user.birthday.nil? ?  'unknown' : user.birthday.to_s
      targetDate = user.birthday.nil? ?  'unknown' : (deductYears==true ? (Time.now.year - user.birthday.year).to_s : user.birthday.to_s)
      targetGender = user.gender.nil? ? 'unknown' : user.gender
      if ret[targetDate].nil?  # we know there hasn't been any gender assigned to this date
        # ret[targetDate] = Hash.new
         ret[targetDate] = {"male" => 0, "female" => 0, "unknown" => 0}
      end
      if ret[targetDate][targetGender].nil?
        ret[targetDate][targetGender] = Array.new
      end
      ret[targetDate][targetGender] << user
    end
    return ret.sort_by{|k,v| k.to_i}
  end

  def users_to_census_age_count(arr, deductYears=false)
    # e = Episode.friendly.find('who-swallowed-a-fly'); u=e.votes.up.by_type(User).voters; s=e.show
    ret = Hash.new
    arr.each do |user|
      # ret << user.id
      # targetDate = user.birthday.nil? ?  'unknown' : user.birthday.to_s
      targetDate = user.birthday.nil? ?  'unknown' : (deductYears==true ? (Time.now.year - user.birthday.year).to_s : user.birthday.to_s)
      targetGender = user.gender.nil? ? 'unknown' : user.gender
      if ret[targetDate].nil?  # we know there hasn't been any gender assigned to this date
        # ret[targetDate] = Hash.new
        ret[targetDate] = {"male" => 0, "female" => 0, "unknown" => 0}
      end
      if ret[targetDate][targetGender].nil?
        ret[targetDate][targetGender] = 1
      else
        ret[targetDate][targetGender] =  ret[targetDate][targetGender] + 1
      end
    end
    return ret.sort_by{|k,v| k.to_i}
  end


  def users_to_census_gender_count(arr, deductYears=true)
    ret = Hash.new
    arr.each do |user|
      targetDate = user.birthday.nil? ?  'unknown' : (deductYears==true ? (Time.now.year - user.birthday.year).to_s : user.birthday.to_s)
      targetGender = user.gender.nil? ? 'unknown' : user.gender
      if ret[targetGender].nil?
        ret[targetGender] = 1
      else
        ret[targetGender] = ret[targetGender] + 1
      end
    end
    return ret.sort_by{|k,v| k.to_i}
  end



# viddler helpers was originally it's own class
	def vid_embed(episode)
		@viddler ||= Viddler::Client.new(ENV['VIDDLER_ID'])
		@viddler.authenticate! ENV['VIDDLER_USER'], ENV['VIDDLER_PASSWORD']
		@ret =''
		if(episode.embed.provider != 'viddler')
			@ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
		else
			vidid = episode.video
			videoData = @viddler.get 'viddler.videos.getDetails', :video_id => "#{episode.video}"
			# old embed or new with videojs
			if videoData['video']['files'].nil?
				 old = Embed.where(:provider => "viddler_original").first
				 @ret = old.get_embed(old, episode.video).html_safe
			else
				files = ((videoData['video']['files'].each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by{|g| g['width'] }.reverse
				matched = files.select { |vid| vid['width'] = "854" }
				@src = ""
				matched.each do |i|
					@src+= "<source src='#{i['html5_video_source']}' type='#{i['type']}' />"
				end
				@ret = episode.embed.get_embed(episode.embed, vidid).html_safe
				@poster = videoData['video']['thumbnail_url'].empty? ? "" : videoData['video']['thumbnail_url']
				@ret = @ret.gsub("{{poster}}", "poster='#{@poster}'").gsub("{{videosources}}", @src).gsub("%showepisode%", "#{episode.show.title}: #{episode.title}")
			end
		end
		return @ret
	end

	def vid_file(episode)
		@viddler ||= Viddler::Client.new(ENV['VIDDLER_ID'])
		@viddler.authenticate! ENV['VIDDLER_USER'], ENV['VIDDLER_PASSWORD']
		video = @viddler.get 'viddler.videos.getDetails', :video_id => "#{episode.video}"
		files = ((video['video']['files'].each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by {|g| g['width'] }
		vid = files.first
		return vid
	end





    # determine if friend feature is first view of page
    def is_friend_return_view?
      @prevURL = session[:previous_url].nil? ? ""  : session[:previous_url].split('/')[0..2].join('/')
      @curURL = request.fullpath.split('/')[0..2].join('/')
      return ( @curURL == @prevURL)
      # return false
    end

end
