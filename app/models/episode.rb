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

	has_attached_file :image,
	    :styles => { large: "864x486>", :thumb => "150x150>" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/:class/:id/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"


	private

	def slug_candidates
		[
			[show.title,  title],
			[show.title, title,  Time.now.strftime('%Y-%m-%d-%H:%M:%S ') ]

		]
	end

	def episode_params
		params.require(:episode).permit(:title, :description, :approved, :show_id, :slug)
	end
	

end
