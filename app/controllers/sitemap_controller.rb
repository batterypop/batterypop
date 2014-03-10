class SitemapController < ApplicationController
   def index
      redirect_to "http://#{ENV['AWS_BUCKET']}.s3.amazonaws.com/sitemaps/sitemap.xml.gz"
   end  
end