json.array! @uninvited_users do |user|
  json.value user.id
   json.label "#{user.name} <#{user.email}>"
end



# @uninvited_users.map{|u| {"value" => u.id, "label" => "#{u.name} <#{u.email}>"} }.to_json.html_safe
