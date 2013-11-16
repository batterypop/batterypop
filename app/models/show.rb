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
	friendly_id :slug_candidates, use: :slugged
	
	
	acts_as_followable
	belongs_to :creator

	has_many :episodes, :order => 'episode ASC'
	has_and_belongs_to_many :channels, :join_table => :channels_shows

	accepts_nested_attributes_for :episodes, :allow_destroy => true
		#:reject_if => ->(e) { e[:title].blank? }, :allow_destroy => true


	has_attached_file :image,
	    :styles => { large: "864x486>", :thumb => "150x150#" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/:class/:id/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"

	has_attached_file :background,
	    :styles => { background: "1600x1100>", large: "864x486>", thumb: "150x150#" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/:class/:id/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"




def self.created_yesterday
	created_between((Time.zone.now-1.day).beginning_of_day, (Time.zone.now-1.day).end_of_day)
end

def self.created_last_week
	created_between((Time.zone.now-1.week).beginning_of_day, Time.zone.now)
end

def self.created_last_month
	created_between((Time.zone.now-1.month).beginning_of_day, Time.zone.now)
end

def self.created_last_year
	created_between((Time.zone.now-1.year).beginning_of_day, Time.zone.now)
end

scope :created_between, lambda { |start_time, end_time| where(:created_at => (start_time...end_time)) }





scope :approved,  -> {where(:approved => true)}
scope :not_approved,  ->  {where(:approved => false)}


# scope :promoted, where (:promote => true)
scope :promoted,  ->  {where(:promote => true )}

#not sure how best to deal with nul values
scope :skiplistnil, -> {where(:skiplist => nil)}
scope :skiplisttrue, ->{where(:skiplist => true)}
scope :skiplistfalse, ->{where(:skiplist => false)}

scope :showlist, -> {where(:skiplist => [false, nil])}

scope :shorts,  -> {where(:single => true, :approved => true)}






	private
	

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

	def show_params
		params.require(:show).permit(:title, :description, :single, :slug, :episodes_attributes, :image, :background)
	end

	

end
