class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  # POST /news/:news_id/comments
  # POST /news/:news_id/comments.json
  def create
    @comment = if params[:news_id]
                 News.find(params[:news_id]).comments.new(comment_params)
               else
                 Comment.new(comment_params)
               end

    location_city = request.location.city.empty? ? 'Unknown' : request.location.city
    location_country = request.location.country.empty? ? 'Unknown' : request.location.country

    @comment.published!
    @comment.author_ip = request.remote_ip
    @comment.author_location = "#{location_city}, #{location_country}"

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: 'Комментарий успешно добавлен!' }
        format.json { render :show, status: :created, location: @comment.commentable }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:email, :author, :text)
    end
end
