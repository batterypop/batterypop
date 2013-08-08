json.array!(@episodes) do |episode|
  json.extract! episode, :title, :description, :approved, :creator_id, :show_id, :video_type, :video_id
  json.url episode_url(episode, format: :json)
end
