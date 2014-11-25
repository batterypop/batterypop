class ChicagoVote < ActiveRecord::Base
	belongs_to :voteable, :polymorphic => true

	has_many :episodes
	# belongs_to :episode

end
