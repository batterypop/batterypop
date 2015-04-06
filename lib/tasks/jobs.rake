namespace :jobs do
  task :work => :environment do
    Match.all.each do |m|
      status = m.status
      advanced = m.advance! Time.now
      if advanced
        puts "Advanced match #{m.player_one.title} --VS-- #{m.player_two.title} from #{status} to #{m.status}"
      end
    end
  end
end
