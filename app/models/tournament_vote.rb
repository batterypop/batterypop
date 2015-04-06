class TournamentVote < ActiveRecord::Base
  belongs_to :match
  belongs_to :episode
end
