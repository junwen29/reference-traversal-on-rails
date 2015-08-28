json.array!(@items) do |item|
  json.extract! item, :id, :name, :season, :itemType, :minTemp, :maxTemp
  json.url item_url(item, format: :json)
end
