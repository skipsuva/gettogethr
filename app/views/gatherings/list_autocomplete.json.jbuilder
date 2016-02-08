json.array! @uninvited_users do |user|
  json.label "#{user.name} <#{user.email}>"
  json.value user.id
end
