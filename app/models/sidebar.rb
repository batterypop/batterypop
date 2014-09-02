class Sidebar < ActiveRecord::Base
	has_many :links, :as => :linkedmedia


end