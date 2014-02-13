class FriendEpisode < ActiveRecord::Base
  belongs_to :friend
  belongs_to :episode
end
