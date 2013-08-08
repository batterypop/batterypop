class Show < ActiveRecord::Base
	belongs_to :creator

	
	has_many :episodes
end
