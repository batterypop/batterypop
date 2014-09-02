class Link < ActiveRecord::Base
	belongs_to :linkedmedia, :polymorphic =>  true

	has_many :visits
	has_many :sidebars


	def self.sidebar_from_link(str)
		Link.find_by(:link_type => 'url', :url => str).linkedmedia
		# return link
	end


	def link_params
		params.require(:link).permit(:url, :type, :views)
	end

	scope :urls, -> {where(:link_type => 'url')}
	scope :files, -> {where(:link_type => 'file')}
end