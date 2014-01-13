# == Schema Information
#
# Table name: username_words
#
#  id         :integer          not null, primary key
#  kind       :string(255)
#  word       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UsernameWord < ActiveRecord::Base
end
