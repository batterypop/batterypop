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
	acts_as_taggable_on :tags

	belongs_to :show
	has_one :creator, :through => :show
	belongs_to :embed


	# dealing with suggested or related episodes 
	has_many :suggestions, :foreign_key => "episode_id", :class_name => "Suggestion"
	has_many :related_episodes, :through => :suggestions

	accepts_nested_attributes_for :suggestions, :allow_destroy => true
	accepts_nested_attributes_for :related_episodes, :allow_destroy => true

	has_attached_file :image,
	    :styles => { large: "864x486>", :thumb => "150x150#" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/:class/:id/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"


	def self.mostpopped(lim=nil	)
		# @episodes = Episode.where(:approved => true).order('cached_votes_up DESC').limit(lim)
		# @episodes = Episode.where(:approved => true).joins(:show).where(:approved => true).order('cached_votes_up DESC').limit(lim)
		@episodes = Episode.joins(:show).where(:approved => true, "shows.approved" => true).order('cached_votes_up DESC').limit(lim)
	end


	private

	def slug_candidates
		[
			[title],
			[title, 2],
			[title, 3],
			[title, 4],
			[title, 5],
			[title, 6],
			[title, 7],
			[title, 8],
			[title, 9],
			[title,  Time.now.strftime('%M:%S') ]

		]
	end

	def episode_params
		params.require(:episode).permit(:title, :description, :approved, :show_id, :slug)
	end
	

end
