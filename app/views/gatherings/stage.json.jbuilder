json.gathering_title @gathering.title

json.moments @gathering.moments do |moment|
  json.time moment.time
  json.id moment.id
  json.suggested moment.suggested?
end

json.places @gathering.places do |place|
  json.name place.name
  json.id place.id
  json.suggested place.suggested?
end

json.activities @gathering.activities do |activity|
  json.description activity.description
  json.id activity.id
  json.suggested activity.suggested?
end
