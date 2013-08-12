json.array!(@categories) do |category|
  json.extract! category, :title, :description, :slug
  json.url category_url(category, format: :json)
end
