# == Schema Information
#
# Table name: creators
#
#  id                      :integer          not null, primary key
#  username                :string(255)
#  displayname             :string(255)
#  email                   :string(255)
#  encrypted_password      :string(255)
#  bio                     :text
#  created_at              :datetime
#  updated_at              :datetime
#  image_file_name         :string(255)
#  image_content_type      :string(255)
#  image_file_size         :integer
#  image_updated_at        :datetime
#  background_file_name    :string(255)
#  background_content_type :string(255)
#  background_file_size    :integer
#  background_updated_at   :datetime
#

class Creator < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	acts_as_messageable

	has_many :shows
	has_many :episodes, :through => :shows

	has_attached_file :image,
	    :styles => { hd: "1056x594>", large: "300x300>", node: "250x250>", :thumb => "100x100>" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/creators/:id/image/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"

	has_attached_file :background,
	    :styles => { full: "1600x1100>", large: "300x300>", node: "250x250>", :thumb => "100x100>" },
	    storage: :s3,
	    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
	    path: "images/creators/:id/background/:attachment/:style/:filename",
	    bucket: S3_BUCKET,
	    default_url: "/assets/missing.png"



# mailboxer
  def mailboxer_email(object)
    return nil
  end


  	private
	

	def slug_candidates
		[
			displayname,
			[displayname, 2],
			[displayname, 3],
			[displayname, 4],
			[displayname, 5],
			[displayname, 6],
			[displayname, 7],
			[displayname, 8],
			[displayname, 9],
			[displayname,  Time.now.strftime('%M:%S') ]
		]
	end

  def creator_params
  end

end
