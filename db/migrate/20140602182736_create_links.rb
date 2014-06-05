class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.text :data
      t.references :linkedmedia, polymorphic: true
      

      t.timestamps
    end
  end
end
