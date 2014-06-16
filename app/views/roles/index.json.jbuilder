json.array!(@roles) do |role|
  json.extract! role, :id, :role_id, :role_name, :enabled
  json.url role_url(role, format: :json)
end
