class Suggestion < ActiveRecord::Base

	 belongs_to :episode, :foreign_key => "episode_id", :class_name  => "Episode"
	 belongs_to :related_episode, :foreign_key => "related_id", :class_name  => "Episode"

	def suggestion_params
		params.require(:suggestion).permit(:episode_id, :related_id)
	end	 

end