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
	has_many :channels, :through => :show




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
		return Episode.joins(:show).where(:approved => true, "shows.approved" => true).order('cached_votes_up DESC').limit(lim).includes(:show)
	end



##  TODO NEED TO CLEAN UP BELOW
# not the best way of doing this I think
	# if (:current_user != :current_admin_user)
	# 	default_scope where(:approved => true)
	# end

	scope :approved, -> {where(:approved => true)}

	def self.default_scope
		approved
	end
	


	def self.nextup(episode, lim=nil)
		# first see if taglist
		@next_episode = episode.show.episodes[episode.show.episodes.index(episode)+1]
		if(!episode.tag_list.empty?)
			@ret = Episode.tagged_with(episode.tag_list, :any => true).reject {|ep| ep == episode}
			@ret = @ret.sample(lim).uniq
			if(!@next_episode.nil?)
				@ret.unshift(@next_episode)
			end
			return @ret
		else
			# checking if this episode's show belongs to any channels
			if(!episode.show.channels.empty?)
				@all_episodes = []
				episode.channels.where(:hidden => [nil, false] ).each { |channel|  channel.episodes.joins(:show).where(:approved => true, "shows.approved" => true).each {|ep|  @all_episodes << ep } }
				if(lim.nil?)
					lim = @all_episodes.count
				end
				@all_episodes = @all_episodes.reject {|ep| ep == episode}
				# return (!@next_episode.nil?)  ?  @all_episodes.sample(lim).unshift(@next_episode) : @all_episodes.sample(lim)
				@all_episodes = @all_episodes.sample(lim);
				if(!@next_episode.nil?)
					@all_episodes.unshift(@next_episode)
				end
				return @all_episodes
			else
				# not belong to any channels so most popped?
				@most =   Episode.mostpopped(lim).reject{|ep| ep == episode}
				if(!@next_episode.nil?) 
					@most.unshift(@next_episode)
				end
				return @most
			end
		end
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
