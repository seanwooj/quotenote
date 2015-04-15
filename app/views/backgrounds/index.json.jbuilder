json.array!(@backgrounds) do |background|
  json.extract! background, :id
  json.url background_url(background, format: :json)
end
