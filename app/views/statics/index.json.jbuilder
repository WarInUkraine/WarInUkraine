json.array!(@statics) do |static|
  json.extract! static, :id, :url, :title, :html
  json.url static_url(static, format: :json)
end
