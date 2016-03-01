namespace :shows do
	task :sort_titles => :environment do
		shows = Show.where(sort_title: nil)
		shows.each do |s|
			s.save
		end
	end
end
