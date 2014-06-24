cache [@channel, 'rss'], skip_digest: true,  :expires_in => 8.hours  do

xml.instruct! :xml, :version => "1.0"

	xml.rss(:version => "2.0", "xmlns:media" => 'http://search.yahoo.com/mrss/', "xmlns:atom" => "http://www.w3.org/2005/Atom")  do
	
	xml.channel do
		xml.title "BatteryPOP: #{@channel.title}"
		xml.description do
			xml.cdata!(@channel.description)
		end
		if @channel.icon.present?
			xml.image(:width => '300', :height => '300', :url => @channel.icon(:large))
		else
			xml.image ""
		end
		
		xml.language "en-us"
		xml.link channel_url
		
		@channel.shows.each do |show|
			show.episodes.each do |episode|
				xml.item do
					xml.comment! "Video"
					xml.title "#{show.title}: #{episode.title}"
					xml.pubDate "#{episode.created_at}"
					# xml.description "#{show.description} #{episode.description}"
					# xml.description xml.cdata!("TEST")
					xml.description do
						xml.cdata!("#{show.description} #{episode.description}")
					end
					xml.thumbnail "#{episode.image(:thumb)}"
					# xml.source
					# need to get episode.embed with code 
					xml.pubDate episode.created_at.to_s(:rfc822)
					xml.link "#{show_episode_url(show, Episode.friendly.find(episode.id))}"
					xml.guid "#{show_episode_url(show, Episode.friendly.find(episode.id))}"

					xml.embed do
						# xml.cdata!(vid_embed(episode))
					end

					if episode.embed.provider == 'viddler'
						links = vid_file(episode)
						

						# should there be multiple video sizes? If not viddler?

						xml.media :group do

							links.each do | link |

								data = ActiveSupport::JSON.decode(link.data)

								xml.media(
									:content, 
									# :url => "http://www.batterypop.com/links/#{link.id}/feed", 
									:url => "#{feed_link_url(link)}?channel=#{@channel.title}",
									:type =>  data['type'],
									:width => data["width"],
							        :height => data["height"],
					        		:size => data["size"],
					        		:profile => data['profile_name'],
					        		:poster => data['poster']
								)
							end

							xml.media(
								:thumbnail,
								:url => "#{episode.image(:large)}",
								:width => "864", 
								:height => "486"
							)

						end
					end
				end
			
			end
		end
	end
end
end