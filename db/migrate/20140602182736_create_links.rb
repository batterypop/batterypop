class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :type
      t.references :linkedmedia, polymorphic: true
      t.integer :views, :default => 0

      t.timestamps
    end
  end
end
