class CreateSidebars < ActiveRecord::Migration
  def change
    create_table :sidebars do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
