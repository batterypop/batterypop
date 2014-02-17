# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  slug        :string(255)
#  parent_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	has_and_belongs_to_many :posts, :join_table => :categories_posts
	has_many :subcategories, class_name: "Category", foreign_key: "parent_id"
	belongs_to :parent, class_name: "Category"


	def should_generate_new_friendly_id?
	  slug.blank? || title_changed?
	end

	private
	def category_params
		params.require(:category).permit(:title, :description, :slug, :parent_id)
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
