class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :admin_user!, except: [:create]

  # GET /comments
  # GET /comments.json
  # GET /news/:news_id/comments
  # GET /news/:news_id/comments.json
  def index
    @comments = if params[:news_id]
                  News.find(params[:news_id]).comments
                else
                  Comment.all
                end
  end

  # GET /comments/1
  # GET /comments/1.json
  # GET /news/:news_id/comments/1
  # GET /news/:news_id/comments/1.json
  def show
  end

  # GET /comments/new
  # GET /news/:news_id/comments/new
  def new
    @comment = if params[:news_id]
                 News.find(params[:news_id]).comments.new
               else
                 Comment.new
               end
  end

  # GET /comments/1/edit
  # GET /news/:news_id/comments/1/edit
  def edit
  end

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

    @comment.published!

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

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  # PATHC/PUT /news/:news_id/comments/1
  # PATHC/PUT /news/:news_id/comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Комментарий успешно изменен!' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  # DELETE /news/:news_id/comments/1
  # DELETE /news/:news_id/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Комментарий успешно удалён!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = if params[:news_id]
                   News.find(params[:news_id]).comments.find(params[:id])
                 else
                   Comment.find(params[:id])
                 end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:email, :author, :text)
    end
end
