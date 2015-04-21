class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :url
      t.integer :position
      t.boolean :active

      t.timestamps
    end
  end
end
