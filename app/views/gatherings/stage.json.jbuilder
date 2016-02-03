json.moments @gathering.moments do |moment|
  json.time moment.time
   json.suggested moment.suggested?
end

json.places @gathering.places do |place|
  json.name place.name
 json.suggested place.suggested?
end

json.activities @gathering.activities do |activity|
  json.description activity.description
  json.suggested activity.suggested?
end
