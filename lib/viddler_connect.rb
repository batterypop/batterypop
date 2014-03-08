module ViddlerConnect
	class VidAPI

		@@viddler

		def self.initialize
			@@viddler = Viddler::Client.new(ENV['VIDDLER_ID'])
		    @@viddler.authenticate! ENV['VIDDLER_USER'], ENV['VIDDLER_PASSWORD']
		end

		def self.get_viddler
			@@viddler
		end


		def self.get_embed(episode)
			@ret =''
			if(episode.embed.provider != 'viddler')
				@ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
			else
				videoData = @@viddler.get 'viddler.videos.getDetails', :video_id => "#{episode.video}"
				files = ((videoData['video']['files'].each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by{|g| g['width'] }.reverse
				matched = files.select { |vid| vid['width'] = "854" }
				@src = ""
				matched.each do |i|
					@src+= "<source src='#{i['html5_video_source']}' type='#{i['type']}' />"
				end
				@ret = episode.embed.get_embed(episode.embed, episode.video).html_safe
				@poster = videoData['video']['thumbnail_url'].empty? ? "" : videoData['video']['thumbnail_url']
				@ret = @ret.gsub("{{poster}}", "poster='#{@poster}'").gsub("{{videosources}}", @src)
			end
			return @ret
		end

		def self.get_video(episode)
			video = @@viddler.get 'viddler.videos.getDetails', :video_id => "#{episode.video}"
			allfiles = video['video']['files']
			files = ((allfiles.each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by {|g| g['width'] }
			vid = files.first
			return vid
		end

		

	end
end