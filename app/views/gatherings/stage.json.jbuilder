json.gathering_title @gathering.title

# json.moments @gathering.moments do |moment|
json.moments sort_by_suggestion(@gathering.moments) do |moment|
  json.time moment.time.strftime('%_m/%-d/%y at %l:%M %P')
  json.id moment.id
  json.suggested moment.suggested?
end

json.places sort_by_suggestion(@gathering.places) do |place|
  json.name place.name
  json.id place.id
  json.suggested place.suggested?
end

json.activities sort_by_suggestion(@gathering.activities) do |activity|
  json.description activity.description
  json.id activity.id
  json.suggested activity.suggested?
end
