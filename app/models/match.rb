class Match < ActiveRecord::Base
  belongs_to :player_one, class_name: Episode
  belongs_to :player_two, class_name: Episode
  validates_inclusion_of :status,
    in: %w(scheduled active player_one_wins player_two_wins)
end
