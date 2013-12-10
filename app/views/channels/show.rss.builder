xml.instruct! :xml, :version => "1.0"

	xml.rss(:version => "2.0", "xmlns:media" => 'http://search.yahoo.com/mrss/', "xmlns:atom" => "http://www.w3.org/2005/Atom")  do
	
	xml.channel do
		xml.title "BatteryPOP: #{@channel.title}"
		xml.description @channel.description
		xml.link channel_url
		
		@channel.shows.each do |show|
			show.episodes.each do |episode|
				xml.item do
					xml.title "#{show.title}: #{episode.title}"
					xml.pubDate "#{episode.created_at}"
					xml.description "#{show.description} #{episode.description}"
					xml.thumbnail "#{episode.image(:thumb)}"
					# xml.source
					# need to get episode.embed with code 
					xml.pubDate episode.created_at.to_s(:rfc822)
					xml.link "#{show_episode_url(show, Episode.friendly.find(episode.id))}"
					xml.guid "#{show_episode_url(show, Episode.friendly.find(episode.id))}"

					xml.embed episode.embed.code.gsub("{{unbound view.dimensions.width}}", "100%").gsub("{{unbound view.dimensions.height}}", "100%").gsub("{{unbound view.autoplayFlag}}", "1").gsub("{{unbound view.videoId}}", episode.video).html_safe 

					if episode.embed.provider == 'viddler'
						video = @viddler.get 'viddler.videos.getDetails', :video_id => "#{episode.video}"
						allfiles = video['video']['files']
						files = ((allfiles.each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by {|g| g['width'] }
						vid = files.first
						

						# should there be multiple video sizes? If not viddler?

						xml.media :group do
							# xml.media :content => "poo"
							xml.media(
								:content, 
								:url => vid['html5_video_source'], 
								:type =>  vid['type'],
								:width => vid["width"],
						        :height => vid["height"],
				        		:size => vid["size"],
				        		:profile => vid['profile_name']
								)
						end
					end
				end
			
			end
		end
	end
end