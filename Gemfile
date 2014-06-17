source 'https://rubygems.org'

gem 'bundler'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.0'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'
gem 'jquery-ui-rails' 

gem 'respond-js-rails', '~> 1.4.2'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'ZenTest', '~> 4.9.5'


gem 'paperclip',  '>= 3.4.0'  # image upload
gem 'aws-sdk'

gem 'unicorn'

gem 'bootstrap-sass', '~> 3.1.1'
# gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
#                               :github => 'anjlab/bootstrap-rails'

                    
gem 'modernizr-rails' 

# gem 'autoprefixer-rails'       

gem "therubyracer"
# gem "less-rails"

gem 'devise',  github: 'plataformatec/devise'
gem 'devise_security_extension', :github => 'phatworx/devise_security_extension' # security questions


# administration
gem 'activeadmin',         github: 'gregbell/active_admin'
gem 'ransack',             github: 'ernie/ransack'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'formtastic',          github: 'justinfrench/formtastic'
gem "activeadmin-sortable-tree", :github => "nebirhos/activeadmin-sortable-tree", :branch => "master"
gem 'acts-as-taggable-on'

gem 'viddler-ruby'

gem "rich", github: 'bastiaanterhorst/rich'


#gem 'video-js-rails'   # https://github.com/alexesDev/video-js-rails

# gem 'active_admin_editor'

gem 'survey', :git => 'git://github.com/runtimerevolution/survey.git'

# voting
# gem 'acts_as_votable', github: 'ryanto/acts_as_votable' 
# https://github.com/ryanto/acts_as_votable
gem "acts_as_votable", "~> 0.7.1"

gem 'friendly_id', '5.0.0.beta4' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

# gem "bxslider-rails", "~> 4.1.0"
gem "bxslider-rails", github: 'grimmwerks/bxslider-rails', ref: 'db1053d8f49e6fedec6afccdf5c3832d9e8c6b18'   #cutomized fork

gem  'truncate_html'


gem 'mailboxer'  # messaging

# https://github.com/tcocca/acts_as_follower
gem "acts_as_follower", "~> 0.2.0"

# https://github.com/grosser/random_records
gem "random_record"

gem "easy_captcha"


gem "squeel"  # Last officially released gem
# gem "squeel", :git => "git://github.com/ernie/squeel.git" # Track git repo

gem "browser"
# https://github.com/fnando/browser

gem 'pg'

gem 'pg_search'

gem 'chosen-rails'

gem 'awesome_print'

gem 'sitemap_generator'
gem 'carrierwave'
gem 'fog' # if you're using S3  
# NEED TO KEEP SITEMAP NOT ON HEROKU AS ITs readonly
# 

gem 'will_paginate', '~> 3.0.5'
gem  'will_paginate-bootstrap'


gem 'mixpanel-ruby'

gem 'newrelic_rpm'

gem 'memcachier'
gem 'dalli'


gem 'split', "~> 0.7.2", :require => 'split/dashboard'
gem 'redis'

# gem 'google-api-client'
gem 'rack-google-analytics'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'rspec-rails'
  gem 'spork'
  gem 'spork-rails', :github => 'sporkrb/spork-rails'
  gem 'annotate'
   # gem 'sqlite3'
end


group :production do
  # gem 'pg'
  gem 'rails_12factor'
end

group :test do
    gem 'rspec'
    gem 'autotest'
    gem 'autotest-growl'
    gem 'autotest-fsevent', '>= 0.2.9'
    # gem 'sqlite3'
end


gem 'rack-mini-profiler'
# profiler for db calls -- moved lower to 'see' the postgres gem


# VIDEO JS INO
# unfortunately the gem for videojs seemed to be out of sync and there's no gems for the plugins anyway so 
# they would have to be manually entered; so for the time being just have to keep on top of any changes and 
# add each of these plugins manually.  Perhaps secondary I'll create a videojs-batterypop gem that pulls 
# submodules from all these different githubs and keep it updated that way. 
# Youtube:
# https://github.com/eXon/videojs-youtube
# Vimeo: 
# https://github.com/eXon/videojs-vimeo
# Google Analytics
# https://github.com/mickey/videojs-ga
