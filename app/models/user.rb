# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  firstname       :string(255)
#  lastname        :string(255)
#  email           :string(255)
#  username        :string(255)
#  password        :string(255)
#  gender          :string(255)
#  birthday        :date
#  secret_question :integer
#  secret_answer   :string(255)
#  avatar_id       :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
