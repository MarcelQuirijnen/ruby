json.array!(@clients) do |client|
  json.extract! client, :id, :client_id, :firstname, :lastname, :address1, :address2, :city, :zip, :state, :phone, :email, :plan_id, :startdate, :updated
  json.url client_url(client, format: :json)
end
