namespace :jobs do
  task :work => :environment do
    Match.all.each do |m|
      status = m.status
      advanced = m.advance! Time.now
      if advanced
      	unless m.player_one.nil?  || m.player_two.nil?
	        puts "Advanced match #{m.player_one.title} --VS-- #{m.player_two.title} from #{status} to #{m.status}"
	    end
      end
    end
  end
end
