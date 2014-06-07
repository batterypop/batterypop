class AddRequestUriToVisit < ActiveRecord::Migration
  def change
  	add_column :visits, :request_uri, :string
  end
end
