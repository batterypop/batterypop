filename = "#{Rails.root}/config/amazon_s3.yml"
config = YAML.load_file(filename)



S3_BUCKET = config[Rails.env]['bucket']
S3_ACCESS_KEY_ID = config[Rails.env]['access_key_id']
S3_SECRET_ACCESS_KEY = config[Rails.env]['secret_access_key']

Paperclip::Attachment.default_options.merge!({
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
  :bucket => S3_BUCKET,
})