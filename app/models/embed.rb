class Embed < ActiveRecord::Base
	has_many :episodes
	validates_uniqueness_of :provider

	def get_embed(embed, video)
		embed.code.gsub("{{unbound view.dimensions.width}}", "100%").gsub("{{unbound view.dimensions.height}}", "100%").gsub("{{unbound view.autoplayFlag}}", "1").gsub("{{unbound view.videoId}}", video)
	end
end
