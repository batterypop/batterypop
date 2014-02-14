# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  position   :integer
#  active     :boolean
#  seconds	  :integer
#  owner_id   :integer 
# 
# 
#
## need to add time, owner_id? owner_class? has_many_through
#

class Feature < ActiveRecord::Base

	belongs_to :owner, :polymorphic => true

	def feature_params
		params.require(:feature).permit(:title, :content)
	end

	scope :active, -> {where(:active => true).order(:position)}
	scope :homepage, -> {where(:owner_type => nil)}

end
