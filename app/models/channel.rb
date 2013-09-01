class Channel < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	
	has_and_belongs_to_many :shows, :join_table => :channels_shows
end
