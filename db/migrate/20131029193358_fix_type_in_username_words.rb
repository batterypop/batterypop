class FixTypeInUsernameWords < ActiveRecord::Migration
  def change
  	rename_column :username_words, :type, :kind
  end
end
