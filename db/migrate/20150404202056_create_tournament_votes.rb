class CreateTournamentVotes < ActiveRecord::Migration
  def change
    create_table :tournament_votes do |t|
      t.references :match, index: true
      t.references :episode, index: true
      t.string :address

      t.timestamps
    end
  end
end
