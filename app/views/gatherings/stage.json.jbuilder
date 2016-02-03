json.gathering_title @gathering.title

json.moments @gathering.moments do |moment|
  json.time moment.time
  json.id moment.id
  if moment == @gathering.moments.first
    json.suggested true
  else
    json.suggested false
  end
end

json.places @gathering.places do |place|
  json.name place.name
  json.id place.id

  if place == @gathering.places.first
    json.suggested true
  else
    json.suggested false
  end
end

json.activities @gathering.activities do |activity|
  json.description activity.description
  json.id activity.id

  if activity == @gathering.activities.first
    json.suggested true
  else
    json.suggested false
  end
end
