Split.configure do |config|
	config.enabled = !Rails.env.test?
	# Split.redis = REDIS
	# Split::Dashboard.use Rack::Auth::Basic do |username, password|
	# 	username == 'username' && password == 'password'
	# end
end