json.array!(@role_grants) do |role_grant|
  json.extract! role_grant, :id
  json.url role_grant_url(role_grant, format: :json)
end
