class CreatePagesSidebarsJoin < ActiveRecord::Migration
  def change
    create_table :pages_sidebars do |t|
    	t.references :page
		t.references :sidebar
    end
  end
end
