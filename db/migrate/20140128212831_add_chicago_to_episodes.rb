class AddChicagoToEpisodes < ActiveRecord::Migration
	# I realize this is pretty goofy to call the column 'chicago' but thought perhaps 'pops' might be used in the future
  def change
  	add_column :episodes, :chicago, :integer
  end
end
