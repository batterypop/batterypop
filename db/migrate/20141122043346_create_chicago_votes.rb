class CreateChicagoVotes < ActiveRecord::Migration
  def change
    create_table :chicago_votes do |t|
		t.references :voteable, :polymorphic => true, :null => false
		t.boolean :vote_flag, :null => false, :default => true
		t.timestamps
    end
  end
end
