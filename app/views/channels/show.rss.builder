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
					# xml.source
					# need to get episode.embed with code 
					xml.pubDate episode.created_at.to_s(:rfc822)
					xml.link "#{show_episode_url(show, Episode.friendly.find(episode.id))}"
					xml.guid "#{show_episode_url(show, Episode.friendly.find(episode.id))}"

					video = @viddler.get 'viddler.videos.getDetails', :video_id => "#{episode.video}"
					allfiles = video['video']['files']
					files = ((allfiles.each{|f| f.clear unless(!f['html5_video_source'].empty?)  }).reject{ |e| e.empty? }).sort_by {|g| g['width'] }

					# @url = "http://api.viddler.com/api/v2/viddler.videos.getDetails.json?video_id=#{episode.video}&api_key=1ftfdc24uw7rv3pxqv51&sessionid=#{@sessionid}"
					# rez = ::RestClient.get(@url)
					# xml.test rez.inspect

					xml.video files.first['html5_video_source']

					# xml.media(:group => ())
					# xml.media("media:content" => (:audioCodec => "mp4a", :bitrate => 33333))
					xml.media :group do
						# xml.media :content => "poo"
						xml.media(
							:content, 
							:url => "some-image-url", 
							:type => "image/jpeg"
							)
					end
				end
			
			end
		end
	end
end