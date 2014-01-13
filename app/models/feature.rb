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
#

class Feature < ActiveRecord::Base


	def feature_params
		params.require(:feature).permit(:title, :content)
	end

	scope :active, -> {where(:active => true).order(:position)}

end
