# == Schema Information
#
# Table name: episodes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  approved    :boolean
#  creator_id  :integer
#  show_id     :integer
#  video_type  :integer
#  video_id    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Episode < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged, :use => :scoped, :scope => :show

	acts_as_votable


	belongs_to :show
	has_one :creator, :through => :show
	belongs_to :embed


	private

	def slug_candidates
		[
			[show.title,  title],
			[show.title, title,  Time.now.strftime('%Y-%m-%d-%H:%M:%S ') ]

		]
	end
	

end
