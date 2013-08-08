class Episode < ActiveRecord::Base

	belongs_to :show
	has_one :creator, :through => :show

end
