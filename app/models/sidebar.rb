class Sidebar < ActiveRecord::Base
	has_many :links, :as => :linkedmedia, :order => 'links.created_at ASC'

end