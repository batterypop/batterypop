class AddDeviseToCreators < ActiveRecord::Migration
  def change
  	add_column :creators, :reset_password_token, :string
  	add_column :creators, :reset_password_sent_at, :datetime
  	add_column :creators, :remember_created_at, :datetime
  	add_column :creators, :sign_in_count, :integer, :default =>0
  	add_column :creators, :current_sign_in_at, :datetime
  	add_column :creators, :last_sign_in_at, :datetime
  	add_column :creators, :current_sign_in_ip, :string
    add_column :creators, :last_sign_in_ip, :string

  	# t.integer  :sign_in_count, :default => 0
   #    t.datetime :current_sign_in_at
   #    t.datetime :last_sign_in_at
   #    t.string   :current_sign_in_ip
   #    t.string   :last_sign_in_ip

       add_index :creators, :reset_password_token, :unique => true
       # add_index :creators, :email,                :unique => true
  end
end
