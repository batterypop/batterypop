class Episode < ActiveRecord::Base

	belongs_to :show
	has_one :creator, :through => :show
	has_and_belongs_to_many :categories, :join_table => :categories_episodes

end
