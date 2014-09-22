class ChangeUsersToKpass < ActiveRecord::Migration
  #  getting rid of local user info and going pure kpass
  def change
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :encrypted_password
    remove_column :users, :security_question_id
    remove_column :users, :security_question_answer
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    # attempting first to keep permissions as serialized data; 
    add_column :users, :permissions, :text
  end
end
