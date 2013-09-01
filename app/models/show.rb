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
	has_and_belongs_to_many :channels, :join_table => :channels_shows

	accepts_nested_attributes_for :episodes
		# :reject_if => ->(e) { e[:title].blank? }, :allow_destroy => true


	private

	def show_params
		params.require(:show).permit(:title, :description, :single, :slug, :episodes_attributes)
	end

end
