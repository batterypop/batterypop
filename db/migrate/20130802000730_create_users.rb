class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email,    :default => ""
      t.string :username, :null => false, :default => ""
      t.string :encrypted_password
      t.string :gender
      t.date :birthday
      t.integer :security_question_id
      t.string :security_question_answer
      t.integer :avatar_id

      t.timestamps
    end
  end
end
