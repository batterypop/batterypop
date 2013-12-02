class CreateCategoryPostJoinTable < ActiveRecord::Migration
  def change
  	create_table :categories_posts, :id => false do |t|
  		t.references :category
  		t.references :post
  	end
  end
end
