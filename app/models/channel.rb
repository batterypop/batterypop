class Channel < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	

	has_and_belongs_to_many :shows, :join_table => :channels_shows
	has_many :subchannels, class_name: "Channel",  foreign_key: "parent_id"
  	belongs_to :parent, class_name: "Channel"
  	


  	def self.get_channels
  		Channel.includes(:shows).order('channels.position')
  	end

  	def self.get_channels_approved
  		Channel.order('channels.position').includes(:shows).where(shows:{approved: true})
  	end

	private
	def slug_candidates
		[
			title,
			[title, 2],
			[title, 3],
			[title, 4],
			[title, 5],
			[title, 6],
			[title, 7],
			[title, 8],
			[title, 9],
			[title,  Time.now.strftime('%M:%S') ]
		]
	end

	def channel_params
		params.require(:channel).permit(:title, :description,  :slug, :parent_id)
	end

end
