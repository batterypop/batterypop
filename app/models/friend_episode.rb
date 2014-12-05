class FriendEpisode < ActiveRecord::Base
	default_scope :order => "position ASC"
	belongs_to :friend
	belongs_to :episode
end
