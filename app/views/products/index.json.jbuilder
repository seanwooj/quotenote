json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :api_name
  json.url product_url(product, format: :json)
end
