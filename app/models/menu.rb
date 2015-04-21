class Menu < ActiveRecord::Base

	scope :active, -> {where(:active => true).order('position ASC')}
end
