class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :subject
      t.text :body
      t.string :ip
      t.integer :user_id

      t.timestamps
    end
  end
end
