# == Schema Information
#
# Table name: posts
#
#  id                          :integer          not null, primary key
#  title                       :string(255)
#  body                        :text
#  slug                        :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  featured_image_file_name    :string(255)
#  featured_image_content_type :string(255)
#  featured_image_file_size    :integer
#  featured_image_updated_at   :datetime
#

class Post < ActiveRecord::Base
	include PgSearch
	# multisearchable :against => [:title , :body]

	pg_search_scope :search_text,
              :against => [:title, :body],
              :using => {
                :tsearch => {:prefix => true}
              }

	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	acts_as_taggable_on :tags, :keywords

	has_and_belongs_to_many :categories, :join_table => :categories_posts

	has_attached_file :featured_image, 
		:styles => { large: "864x486>", :thumb => "150x150#" },
		s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/:class/:id/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"

	validates_attachment_content_type :featured_image, :content_type => /\Aimage\/.*\Z/


    default_scope :order => "created_at DESC"
    scope :published, lambda { where("created_at <= ?", Time.zone.now) }
  	scope :latest, lambda { |n| published.limit(n) }


	#search return helpers
	def link
		return "/posts/" + self.slug
	end

	def thumb
		return (self.featured_image(:thumb))
	end

	def search_valid?
		valid?
	end

	def should_generate_new_friendly_id?
	  slug.blank? || title_changed?
	end

	private
	
	def post_params
		params.require(:post).permit(:title, :body, :slug, :featured_image)
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
