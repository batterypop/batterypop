# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.batterypop.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  #   
  #   
  # basic pages
  add "/"

  add "/shows", :changefreq => 'weekly'
  add "/channels", :changefreq => 'weekly'
  add "/shorts", :changefreq => 'weekly'
  add "/blog", :changefreq => 'daily'

  add "/about-batterypop"
  add "/terms-and-conditions"
  add "/privacy-policy"
  add "/calling-all-creators"
  add "/advertise-with-us"

  Post.find_each do |post|
  	add post_path(post), :lastmod => post.updated_at
  end
  	
  Show.approved.find_each do |show|
  	add show_path(show), :lastmod => show.updated_at
  	show.episodes.approved.find_each do |ep|
  		add show_episode_path(show, ep), :lastmod => ep.updated_at
  	end
  end

  Creator.where(:hidden => false, :hidden => nil).find_each do |c|
  	add creator_path(c), :lastmod => c.updated_at
  end

  User.find_each do |user|
  	add user_path(user), :lastmod => user.updated_at

end
