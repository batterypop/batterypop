# == Schema Information
#
# Table name: avatars
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Avatar < ActiveRecord::Base

	has_many :users
	
	has_attached_file :image,
    :styles => { large: "300x300>", node: "250x250#", :thumb => "100x100#" },
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
    path: "images/avatars/:id/:attachment/:style/:filename",
    bucket: S3_BUCKET,
    default_url: "/assets/missing.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name
  validates_presence_of :image
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

  before_destroy :reassign_avatars

  def as_json(options = {})
    {
      id: id,
      image_large_url: image(:large),
      image_node_url: image(:node),
      image_thumb_url: image(:thumb),
    }
  end

  protected

  def reassign_avatars
    new_avatar = Avatar.where(["id != ?", id]).first
    User.update_all({ avatar_id: new_avatar.id}, ["avatar_id = ?", id])
  end






end
