json.array!(@contractors) do |contractor|
  json.extract! contractor, :id, :cont_id, :firstname, :lastname, :address1, :address2, :city, :zip, :state, :phone, :email, :startdate, :updated
  json.url contractor_url(contractor, format: :json)
end
