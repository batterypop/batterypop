class Visit < ActiveRecord::Base
	belongs_to :link, :counter_cache => true
	belongs_to :user


	def visit_params
		params.require(:link).permit(:session_id, :http_accept_language, :remote_addr, :data)
	end
end
