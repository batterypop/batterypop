# == Schema Information

class Tournament < ActiveRecord::Base
  include DashboardUtility
  # multisearchable :against => [:title, :description]

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  acts_as_followable

  has_many :matches

  has_attached_file :image,
  :styles => { large: "864x486>",
    :thumb => "150x150#",
    :roku_sd => "214x144^",
    :roku_hd => "290x218^",
    :listing => "200x200>"
  },
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

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :background, :content_type => /\Aimage\/.*\Z/


  #search return helpers
  def link
    return "/tournaments/" + self.slug
  end

  def thumb
    return (self.image(:thumb))
  end

  def search_valid?
    !!(approved)
  end

  # dashboard methods
  def followers_by_gender
    DashboardUtility.users_to_census_gender_count(self.followers, true)
  end

  def followers_by_age
    DashboardUtility.users_to_census_age_count(self.followers, true)
  end

   def hide_sponsor_listing?
    return false
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def self.with_episodes episodes, args
    unless ((Math.log episodes.count, 2) % 1) == 0
      raise ArgumentError, "Number of episodes must be power of two"
    end

    bkt = BracketTree::Bracket::SingleElimination.by_size episodes.count
    relation = BracketTree::PositionalRelation.new(bkt)

    new_tmt = create! args
    pairs = ((episodes.each_with_index).slice_before {|x| x[1].even?}).map {|pair| pair.map &:first}

    pairs.each_with_index do |pair, idx|
      pone, ptwo = pair
      new_tmt.matches.create!(
        player_one: pone, first_seat: relation.round(1).seat(2*idx + 1).position,
        player_two: ptwo, second_seat: relation.round(1).seat(2*idx + 2).position)
    end
    new_tmt
  end

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
  scope :series, -> {where(:single => [false, nil], :approved => true)}

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

  def show_params
    params.require(:show).permit(:title, :description, :single, :slug, :image, :background)
  end
end
