json.array!(@news) do |news|
  json.extract! news, :id, :user_id, :title, :description, :text, :status
  json.url news_url(news, format: :json)
end
