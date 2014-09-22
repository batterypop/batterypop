class ExplodePermissionsToVariables < ActiveRecord::Migration
  def change
    remove_column :users, :permissions
    remove_column :users, :parent_id
    remove_column :users, :email
    # adding perms needed
    add_column :users, :access_to_moderated_chats, :boolean, :default => false
    add_column :users, :youtube_and_3rdparty_videos, :boolean, :default => false
    add_column :users, :publish_public_profile, :boolean, :default => false
    add_column :users, :rejected, :boolean, :default => false
    add_column :users, :approved, :boolean, :default => false
    add_column :users, :parent_email, :string
  end
end
