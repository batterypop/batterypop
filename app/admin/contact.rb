ActiveAdmin.register Contact do
	menu :parent => "Users"


	index do
		column :id
		column :email
		column :subject
		column :body
		column :ip
		column :user,  :member_label => :username
		column :created_at
		default_actions
	end

	show do |contact|
		attributes_table do
			row :subject
			row :email
			row :body do
				simple_format contact.body
			end
			row :ip
			row :user
		end
		active_admin_comments
	end

end