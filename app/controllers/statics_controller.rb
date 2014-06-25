class StaticsController < ApplicationController
  def display
    @static = Static.find_by_url!(params[:url])
    @page_title = @static.title
  end
end
