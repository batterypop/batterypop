class Channel < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	

	has_and_belongs_to_many :shows, :join_table => :channels_shows
	has_many :subchannels, class_name: "Channel",  foreign_key: "parent_id"
  	belongs_to :parent, class_name: "Channel"
  	


	private
	def slug_candidates
		[
			title,
			[ title, Time.now.strftime('%Y-%m-%d-%H:%M:%S ') ]
		]
	end

	def channel_params
		params.require(:channel).permit(:title, :description,  :slug, :parent_id)
	end

end
