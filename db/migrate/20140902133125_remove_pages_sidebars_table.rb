class RemovePagesSidebarsTable < ActiveRecord::Migration
  def change
  	drop_table :pages_sidebars
  end
end
