# == Schema Information
#
# Table name: shows
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  approved    :boolean
#  creator_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  single      :boolean
#

class Show < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged


	belongs_to :creator

	has_many :episodes

end
