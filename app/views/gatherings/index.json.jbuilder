json.array!(@gatherings) do |gathering|
  json.extract! gathering, :id, :title, :owner_id
  json.url gathering_url(gathering, format: :json)
end
