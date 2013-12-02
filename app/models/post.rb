class Post < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	acts_as_taggable_on :tags

	has_and_belongs_to_many :categories, :join_table => :categories_posts

	has_attached_file :featured_image, 
		:styles => { large: "864x486>", :thumb => "150x150#" },
		s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/:class/:id/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"

	private
	
	def post_params
		params.require(:post).permit(:title, :body, :slug, :featured_image)
	end

	def slug_candidates
		[
			title,
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
end
