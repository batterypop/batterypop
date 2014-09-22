class AddNeedsPermissionsToEmbed < ActiveRecord::Migration
  def change
  	add_column :embeds, :needs_permission, :boolean, :default => false
  end
end
