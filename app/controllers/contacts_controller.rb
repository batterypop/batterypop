class ContactsController < ApplicationController

	def new
		
	end

	def create
		# could check if anything is missing and return
		unless current_user.nil?
			params[:contact][:user_id] = current_user.id 
		end
		params[:contact]["ip"] = request.remote_ip

ap(contact_params)

		@contact = Contact.new(contact_params)
		@contact.save
	end

	private
	def contact_params
		params.require(:contact).permit(:email, :subject, :body, :ip, :user_id)
	end

end
