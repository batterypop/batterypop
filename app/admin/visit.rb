ActiveAdmin.register Visit do
  menu :parent => "bPOP Shows"
  
 

 
  
  index :title => proc{ "Visits - #{collection.count}" } do
    column :user, sortable: :user_id
    column "Episode" do |visit|
      link_to visit.link.linkedmedia.title, admin_episode_path(visit.link.linkedmedia)
    end
    column :remote_addr
    column :http_user_agent
    column :http_accept_language
    column :data
    column :created_at
  end
  
end