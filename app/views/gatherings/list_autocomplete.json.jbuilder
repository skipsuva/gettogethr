json.array! @uninvited_users do |user|
  json.value user.id
  json.label "#{user.name} <#{user.email}>"
end
