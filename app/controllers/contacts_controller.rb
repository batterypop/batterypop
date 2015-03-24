class ContactsController < ApplicationController

	def new
		@banner_ad = "/31902320/Shows_Leaderboard"
		@banner_id = 'div-gpt-ad-1411894829676-0'
		@dfp_header = "shows"
		@active = "contact"
	end

	def create
	   @banner_ad = "/31902320/Shows_Leaderboard"
	    @banner_id = 'div-gpt-ad-1411894829676-0'
		@dfp_header = "shows"
		 @active = "contact"
		# could check if anything is missing and return
		unless current_user.nil?
			params[:contact][:user_id] = current_user.id 
		end
		params[:contact]["ip"] = request.remote_ip


		@contact = Contact.new(contact_params)
		@contact.save
	end

	private
	def contact_params
		params.require(:contact).permit(:email, :subject, :body, :ip, :user_id)
	end

end
