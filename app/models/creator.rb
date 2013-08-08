class Creator < ActiveRecord::Base

	has_many :shows
	has_many :episodes, :through => :shows
end
