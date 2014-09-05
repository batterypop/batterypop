class Link < ActiveRecord::Base
	belongs_to :linkedmedia, :polymorphic =>  true

	# default_scope order('created_at DESC')

	# has_many :visits
	has_many :sidebars


	def self.sidebar_from_link(str)
		unless Link.find_by(:link_type => 'url', :url => str).nil?
			return	Link.find_by(:link_type => 'url', :url => str).linkedmedia
		end
	end


	def link_params
		params.require(:link).permit(:url, :type, :views)
	end

	scope :urls, -> {where(:link_type => 'url')}
	scope :files, -> {where(:link_type => 'file')}
end