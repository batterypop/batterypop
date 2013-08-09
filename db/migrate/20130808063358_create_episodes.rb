class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :description
      t.boolean :approved
      t.integer :creator_id
      t.integer :show_id
      t.integer :video_type
      t.string :video_id
      # t.belongs_to :show

      t.timestamps
    end
  end
end
