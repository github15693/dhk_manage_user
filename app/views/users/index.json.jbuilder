json.array!(@users) do |user|
  json.extract! user, :id, :user_id, :name, :address, :userName, :passWord, :enabled
  json.url user_url(user, format: :json)
end
