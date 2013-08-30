class Embed < ActiveRecord::Base
	has_many :episodes
	validates_uniqueness_of :provider
end
