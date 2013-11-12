xml.instruct! :xml, :version => "1.0"
	xml.rss :version => "2.0" do
	xml.channel do
		xml.title "BatteryPOP: #{@channel.title}"
		xml.description @channel.description
		xml.link channel_url
		
		@channel.shows.each do |show|
			show.episodes.each do |episode|
				xml.item do
					xml.title "#{show.title}: #{episode.title}"
					xml.description "#{show.description} #{episode.description}"
					# xml.source
					# need to get episode.embed with code 
					xml.pubDate episode.created_at.to_s(:rfc822)
					xml.link "#{show_episode_url(show, Episode.friendly.find(episode.id))}"
					xml.guid "#{show_episode_url(show, Episode.friendly.find(episode.id))}"
				end
			
			end
		end
	end
end