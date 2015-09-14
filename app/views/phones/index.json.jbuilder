json.array!(@phones) do |phone|
  json.extract! phone, :id, :contact_id, :phone, :phone_type
  json.url phone_url(phone, format: :json)
end
