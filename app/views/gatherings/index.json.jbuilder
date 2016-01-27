json.array!(@gatherings) do |gathering|
  json.extract! gathering, :id, :title, :references
  json.url gathering_url(gathering, format: :json)
end
