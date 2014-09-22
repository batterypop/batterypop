class AddUsernameGenderAgeAvatarToUser < ActiveRecord::Migration
  def change
  	add_column :users, :username_avatar_age_gender, :boolean, :default => false
  end
end
