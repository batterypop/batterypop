xml.instruct! :xml, :version => "1.0"

	xml.feed(:version => "2.0", "xmlns:media" => 'http://search.yahoo.com/mrss/', "xmlns:atom" => "http://www.w3.org/2005/Atom")  do
	
	xml.channel do
		xml.title "BatteryPOP: #{@channel.title}"
		xml.description strip_tags(@channel.description)
		xml.link channel_url
		xml.showCount @channel.shows.count

		@channel.shows.each do |show|
			xml.show do
				xml.title show.title
				xml.description strip_tags(show.description)
				xml.thumbnail "#{show.image(:thumb)}"
				xml.episodeCount show.episodes.count

				show.episodes.each do |episode|
					xml.episode do
						xml.title episode.title
						xml.pubDate  episode.created_at
						xml.description  strip_tags(episode.description).html_safe 
						xml.thumbnail episode.image(:thumb)
						# xml.source
						# need to get episode.embed with code 
						xml.pubDate episode.created_at.to_s(:rfc822)
						xml.link show_episode_url(show, Episode.friendly.find(episode.id))
					

						if episode.embed.provider == 'viddler'
							vid = @vidapi.get_video(episode)
							
						
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
end