class CreateUsernameWords < ActiveRecord::Migration
  def change
    create_table :username_words do |t|
      t.string :type
      t.string :word

      t.timestamps
    end
  end
end
