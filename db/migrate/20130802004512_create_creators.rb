class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :username
      t.string :displayname
      t.string :email
      t.string :encrypted_password
      t.text :bio



      t.timestamps
    end
  end
end
