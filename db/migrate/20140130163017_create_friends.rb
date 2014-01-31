class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
    	t.string :title
      t.string :slug
    	t.text :description
      t.string :sponsor
    	t.string :primary_color
    	t.attachment :image
    	t.attachment :background_image
      t.boolean :features_autoplay
      t.string :features_exit


      t.timestamps
    end
  end
end
