class ContactsController < ApplicationController

	def new
		 @active = "contact"
	end

	def create
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
