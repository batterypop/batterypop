ActiveAdmin.register Feature do
	menu :parent => "bPOP Pages", :priority => 1

	sortable

	config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column

	form do |f|
		f.inputs "BatteryPOP Feature" do
			f.input :position, :label => "Slide Position"
			f.input :title,  :required => true 
			f.input :content,  :as => :rich, :allow_embeds => true
			f.input :seconds, :label => "Time", :hint => "Time in milliseconds."
			f.input :active, :label => "Active?", :hint => "Select for active, unselect to hide."
		end
		f.actions
	end


	index :as => :block do |resource|

		links = ''.html_safe
		links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link show_link"
		links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
		links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"


		url = ''.html_safe
		if resource.owner.nil?
			url = "<a href='/'>View Home Page</a>"
		else
			url = link_to resource.owner.title, edit_admin_friend_path(resource.owner)
		end

		panel "#{resource.position}   #{resource.title}   <div style='float: right;'>#{links}</div>".html_safe do
			div :for => resource do
				raw(resource.content + '<br />' + url)
			end
		end
	end

	
end
