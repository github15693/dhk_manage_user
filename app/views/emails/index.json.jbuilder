json.array!(@emails) do |email|
  json.extract! email, :id, :title, :content
  json.url email_url(email, format: :json)
end
