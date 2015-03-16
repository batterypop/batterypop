class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :title
      t.text :description

      t.string :slug
      t.string :subtitle
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.string :background_file_name
      t.string :background_content_type
      t.integer :background_file_size
      t.datetime :background_updated_at
      t.boolean :promote
      t.boolean :skiplist
      t.integer :position

      t.timestamps
    end

    create_table :matches do |t|
      t.integer :first_seat
      t.integer :second_seat

      t.integer :player_one_id
      t.foreign_key :episodes, column: "player_one_id"

      t.integer :player_two_id
      t.foreign_key :episodes, column: "player_two_id"

      t.datetime :start
      t.datetime :finish

      t.belongs_to :tournament

      t.string :status, default: "scheduled"

      t.timestamps
    end

    create_table :episodes_tournaments , id: false do |t|
      t.integer :episode_id, null: false, index: true
      t.integer :tournament_id, null: false, index: true
    end
  end
end
