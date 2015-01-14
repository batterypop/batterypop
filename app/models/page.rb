class Page < ActiveRecord::Base
	# include PgSearch
	# multisearchable :against => [:title, :content]

	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	acts_as_taggable_on  :keywords


	def should_generate_new_friendly_id?
	  slug.blank? || title_changed?
	end

	private
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

	def page_params
		params.require(:page).permit(:title, :content)
	end
end
