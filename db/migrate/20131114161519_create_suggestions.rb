class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
    	t.integer :episode_id
    	t.integer :related_id
      t.timestamps
    end
  end
end