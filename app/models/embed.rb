# == Schema Information
#
# Table name: embeds
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  code       :text
#  created_at :datetime
#  updated_at :datetime
#

class Embed < ActiveRecord::Base
	has_many :episodes
	validates_uniqueness_of :provider

  def get_embed(embed, video, autoplay="1")
    puts "{{unbound view}}"
		embed.code.gsub("{{unbound view.dimensions.width}}", "100%").gsub("{{unbound view.dimensions.height}}", "100%").gsub("{{unbound view.autoplayFlag}}", autoplay).gsub("{{unbound view.videoId}}", video)
	end
end
