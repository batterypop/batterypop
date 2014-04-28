module DashboardUtility
	def self.users_to_census_age_array(arr, deductYears=false)
    ret = Hash.new
    arr.each do |user|
      # ret << user.id
      # targetDate = user.birthday.nil? ?  'unknown' : user.birthday.to_s
      targetDate = user.birthday.nil? ?  'unknown' : (deductYears==true ? (Time.now.year - user.birthday.year).to_s : user.birthday.to_s)
      targetGender = user.gender.nil? ? 'unknown' : user.gender
      if ret[targetDate].nil?  # we know there hasn't been any gender assigned to this date
        # ret[targetDate] = Hash.new
         ret[targetDate] = {"male" => 0, "female" => 0, "unknown" => 0}
      end
      if ret[targetDate][targetGender].nil?
        ret[targetDate][targetGender] = Array.new
      end
      ret[targetDate][targetGender] << user
    end
    return ret.sort_by{|k,v| k.to_i}
  end

  def self.users_to_census_age_count(arr, deductYears=false)
    # e = Episode.friendly.find('who-swallowed-a-fly'); u=e.votes.up.by_type(User).voters; s=e.show
    # h[key] ? h[key] << category[:id] : h[key] = [category[:id]]
    ret = Hash.new
    arr.each do |user|
      # ret << user.id
      # targetDate = user.birthday.nil? ?  'unknown' : user.birthday.to_s
      targetDate = user.birthday.nil? ?  'unknown' : (deductYears==true ? (Time.now.year - user.birthday.year).to_s : user.birthday.to_s)
      targetGender = user.gender.nil? ? 'unknown' : user.gender
      if ret[targetDate].nil?  # we know there hasn't been any gender assigned to this date
        # ret[targetDate] = Hash.new
        ret[targetDate] = {"male" => 0, "female" => 0, "unknown" => 0}
      end
      if ret[targetDate][targetGender].nil?
        ret[targetDate][targetGender] = 1
      else
        ret[targetDate][targetGender] =  ret[targetDate][targetGender] + 1
      end
    end
    return ret.sort_by{|k,v| k.to_i}
  end


  def self.users_to_census_gender_count(arr, deductYears=true)
    # ret = Hash.new
    ret = {"male" => 0, "female" => 0, "unknown" => 0}
    arr.each do |user|
      targetDate = user.birthday.nil? ?  'unknown' : (deductYears==true ? (Time.now.year - user.birthday.year).to_s : user.birthday.to_s)
      targetGender = user.gender.nil? ? 'unknown' : user.gender
      if ret[targetGender].nil?
        ret[targetGender] = 1
      else
        ret[targetGender] = ret[targetGender] + 1
      end
    end
    return ret.sort_by{|k,v| k}
  end


  def self.chart_data_to_donut(arr)
    h = Array.new
    arr.each do |item|
      h << {"label" => item[0], "value" => item[1].to_s}
    end
    return h
  end


  def self.chart_data_to_bar(arr)
    h = Array.new
    arr.each do |item|
      x = Hash.new
      x[:y] = item[0]
      item[1].each{|k,v| x[k.to_sym] = v}
      h << x
    end
    return h
  end



  # def self.voters_from_show_episodes(show)
  # 	# a.inject([]) { |result,h| result << h unless result.include?(h); result }
  # 	# show.episodes.inject([]){|res, ep| ep.votes.up.by_type(User).voters.each do |voter|}
  # 	h = Array.new
  # 	show.episodes.each do |ep|
  # 		voters = ep.votes.up.by_type(User).voters
  # 		voters.each do |voter|
  # 			h << voter unless h.include?(voter)
  # 		end
  # 	end
  # 	return h
  # end


end