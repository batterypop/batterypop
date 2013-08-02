class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email,    :null => false, :default => ""
      t.string :username, :null => false, :default => ""
      t.string :password
      t.string :gender
      t.date :birthday
      t.integer :secret_question
      t.string :secret_answer
      t.integer :avatar_id

      t.timestamps
    end
  end
end
