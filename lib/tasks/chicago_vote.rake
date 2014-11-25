namespace :chicago_vote do
	task :from_cache => :environment do
		eps = Episode.all
		eps.each do |ep|
			# puts ep.id
			# need to see if there are already exising chicago_votes and if they match
			existCount = ep.chicago_votes.nil? ? 0 : ep.chicago_votes.count
			cachedCount = ep.chicago.nil? ? 0 : ep.chicago


			repeatCount = cachedCount - existCount
			repeatCount.times {ChicagoVote.create(:voteable => ep)}
			puts "#{ep.id} has #{ep.chicago} cached chicago, found #{existCount} chicago_votes, creating #{repeatCount} more"
		end	
	end
end