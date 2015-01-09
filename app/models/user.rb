# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  firstname                :string(255)
#  lastname                 :string(255)
#  email                    :string(255)      default("")
#  username                 :string(255)      default(""), not null
#  encrypted_password       :string(255)
#  gender                   :string(255)
#  birthday                 :date
#  security_question_id     :integer
#  security_question_answer :string(255)
#  avatar_id                :integer
#  created_at               :datetime
#  updated_at               :datetime
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0)
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  parent_id                :integer          default(0), not null
#  slug                     :string(255)
#

class User < ActiveRecord::Base
  include PgSearch
  # multisearchable :against => [:username ]
  pg_search_scope :search_text,
                  :against => :username,
                  :using => {
                    :tsearch => {:prefix => true}
                  }

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_surveys
  acts_as_voter
  acts_as_messageable
  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :authentication_keys => [:username] 


  # has_many :children, class_name: "User",  foreign_key: "parent_id"
  # belongs_to :parent, class_name: "User"
  belongs_to :avatar


  # validates_uniqueness_of :username
  # validates_presence_of :username

  scope :viewable, -> {where(:publish_public_profile => true)}
  scope :listable, -> {where(:username_avatar_age_gender => true)}

#search helpers
  def title
    self.username
  end


  def link
    return "/users/" + self.slug
  end

  def thumb(dim=nil)
    self.get_avatar(:thumb, dim)
  end

  def search_valid?
    valid? 
  end

  def index
    redirect_to :root
  end


  def email_required?
    false
  end




  # because some users were created without avatar attached, adding this as part of the model function
  def get_avatar(size = :thumb, dim=nil)
    unless(self.avatar.nil?) 
      img =  ActionController::Base.helpers.image_tag(self.avatar.image(size), size: dim)
    else
      img =  ActionController::Base.helpers.image_tag("missing.png", size: dim)
    end
    return img
  end


  # def hint(params)
  #   @user = User.friendly.find(params[:username])
  #   if @user
  #       @question = SecurityQuestion.find(@user.security_question_id).name
  #   else
  #     @question = nil
  #   end
  # end



  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end


 def user_params
 	params.require(:user).permit(:username, :avatar_id)
 end


 def create
 	@user = User.create(user_params)
 end

# mailboxer
  def mailboxer_email(object)
    return nil
  end

  def age_in_years 
    # Difference in years, less one if you have not had a birthday this year.
    unless(self.birthday.nil?)
      d= Time.now
      a = d.year - self.birthday.year
      a = a - 1 if (
           self.birthday.month >  d.month or 
          (self.birthday.month >= d.month and self.birthday.day > d.day)
      )
      a
    else
      "--"
    end
  end

  ransacker :youtube_and_3rdparty_videos_eq, formatter: proc { |v| puts v.inspect }

  private 
  def slug_candidates
    [
      :username,
      [:username, 2],
      [:username, 3],
      [:username, 4],
      [:username, 5],
      [:username, 6],
      [:username, 7],
      [:username, 8],
      [:username, 9],
      [:username,  Time.now.strftime('%M:%S') ]
    ]
  end

end
