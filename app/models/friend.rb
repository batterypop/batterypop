# == Schema Information
#
# Table name: episodes
#
#  id                 		:integer          not null, primary key
#  title              		:string(255)
#  description        		:text
#  approved           		:boolean
#  slug               		:string(255)
#  sponsor			  		:string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  image_file_name         :string(255)
#  image_content_type      :string(255)
#  image_file_size         :integer
#  image_updated_at        :datetime
#  background_file_name    :string(255)
#  background_content_type :string(255)
#  background_file_size    :integer
#  background_updated_at   :datetime
#  features_autoplay	   :boolean
#  features_exit		   :string(255)

#  episodes

class Friend < ActiveRecord::Base
	include PgSearch
	# multisearchable :against => [:title, :description, :sponsor]

	pg_search_scope :search_text,
                  :against => [:title, :description, :sponsor],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	acts_as_followable

	has_many :friend_episodes
	# has_many :episodes, -> {order('episodes.created_at ASC')} , :through => :friend_episodes
	has_many :episodes, :through => :friend_episodes
	has_many :episodes_approved, :through => :friend_episodes
	has_many :shows, :through => :episodes

	 # -> { select('company_stores.*, customers.name').order('company_stores.id ASC').uniq },
	 # -> { order('created_at DESC') },
	 # -> { select('episodes.*').order('created_at ASC') }
	
	has_many :features, :as => :owner

	accepts_nested_attributes_for :features

	before_save :destroy_images?

	#image stuff
	#
	has_attached_file :sidebar_image,
	    :styles => { large: "400x390>", :thumb => "100x100>"},
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/friends/:id/sidebar_image/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"

	has_attached_file :image,
	    :styles => { large: "300x300>", listing: "200x200>", :thumb => "150x150>" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/friends/:id/image/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"

	has_attached_file :background,
	    :styles => { full: "1600x1100>", large: "300x300>",  :thumb => "100x100>" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/friends/:id/background/:attachment/:style/:filename",
	    bucket: S3_BUCKET

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type :background, :content_type => /\Aimage\/.*\Z/

	scope :approved, -> {where(:approved => true)}

	def link
		"/friends/" + self.slug
	end

	def episode_link(episode)
		self.link + '/episodes/' + episode.slug
	end

	def should_generate_new_friendly_id?
	  slug.blank? || title_changed?
	end


# search helpers
	def thumb
		return self.image(:thumb)
	end

	def search_valid?
		!!(approved)
	end

# image and background delete or update

	def delete_image
		@delete_image ||= "0"
	end
	def delete_image=(value)
		@delete_image = value
	end

	def delete_sidebar_image
		@delete_sidebar_image ||= "0"
	end
	def delete_sidebar_image=(value)
		@delete_sidebar_image = value
	end


	def delete_background
		@delete_background ||= "0"
	end
	def delete_background=(value)
		@delete_background = value
	end


	scope :series, -> {where(:approved => true)}



	private  
	def destroy_images?
	    # self.image.clear if @delete_image == "1"
	    # self.background.clear if @delete_background == "1"
	    self.image = nil if @delete_image == "1"
	    self.background = nil if @delete_background == "1"
	    self.sidebar_image = nil if @delete_sidebar_image == "1"
	end

	def slug_candidates
		[
			:title,
			[:title, 2],
			[:title, 3],
			[:title, 4],
			[:title, 5],
			[:title, 6],
			[:title, 7],
			[:title, 8],
			[:title, 9],
			[:title,  Time.now.strftime('%M:%S') ]
		]
	end

end