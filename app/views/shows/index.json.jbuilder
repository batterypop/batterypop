json.array!(@shows) do |show|
  json.extract! show, :title, :description, :approved
  json.url show_url(show, format: :json)
end
