class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :session_id 
      t.string :http_user_agent
      t.string :http_accept_language
      t.string :remote_addr
      t.text :data
      t.references :user
      t.references :link
      t.timestamps
    end
  end
end
