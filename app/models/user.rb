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
#

class User < ActiveRecord::Base

  has_surveys
  acts_as_voter
  acts_as_messageable
  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username] 


  has_many :children, class_name: "User",  foreign_key: "parent_id"
  belongs_to :parent, class_name: "User"
 


  validates_uniqueness_of :username
  validates_presence_of :username




  def index
    redirect_to :root
  end


  def email_required?
    false
  end

 def user_params
 	params.require(:user).permit(:username)
 end


 def create
 	@user = User.create(user_params)
 end

# mailboxer
  def mailboxer_email(object)
    return nil
  end

end
