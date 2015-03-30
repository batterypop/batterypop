class AddStartDateToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :start_date, :datetime
  end
end
