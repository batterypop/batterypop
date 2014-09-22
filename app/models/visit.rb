class Visit < ActiveRecord::Base
	belongs_to :link, :counter_cache => true
	belongs_to :user

	# has_one :linkedmedia, :through => :link
	# belongs_to :episode, :polymorphic => true
	has_one :linkedmedia, :through => :link


	def visit_params
		params.require(:link).permit(:session_id, :http_accept_language, :remote_addr, :data)
	end
end
