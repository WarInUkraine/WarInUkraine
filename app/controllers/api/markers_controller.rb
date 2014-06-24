class API::MarkersController < API::APIController
  def show
    puts params.to_yaml

    news = News

    if params[:after]
      news = news.where('happened_at > ?', Time.now - params[:after].to_i.hours)
    end

    news_ids = news.all.map(&:id)
    locations = Location.where('locatable_id IN (?) AND locatable_type = ?', news_ids, 'News')

    @hash = Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat    location.lat
      marker.lng    location.lng
      marker.title  location.address

      case location.locatable.class 
        when News.class
          marker.infowindow render_to_string partial: 'news/marker.html.erb', locals: { news: location.locatable }
      end
    end

    @hash.to_json
  end
end