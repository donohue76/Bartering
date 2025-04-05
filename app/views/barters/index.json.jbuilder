json.array!(@barters) do |barter|
  json.extract! barter, :id, :product, :description, :category, :neighborhood, :interested_in, :expiration
  json.url barter_url(barter, format: :json)
end
