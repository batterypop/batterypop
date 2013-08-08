class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.text :description
      t.boolean :approved
      # t.integer :creator_id
      t.belongs_to :creator
      t.has_many :episodes

      t.timestamps
    end
  end
end
