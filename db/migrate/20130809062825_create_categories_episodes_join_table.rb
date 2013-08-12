class CreateCategoriesEpisodesJoinTable < ActiveRecord::Migration
  def change
  	create_table :categories_episodes, :id => false do |t|
	  t.references :episode
	  t.references :category
	end
  end
end
