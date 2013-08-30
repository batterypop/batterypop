class CreateEmbeds < ActiveRecord::Migration
  def change
    create_table :embeds do |t|
      t.string :provider
      t.text :code

      t.timestamps
    end
  end
end
