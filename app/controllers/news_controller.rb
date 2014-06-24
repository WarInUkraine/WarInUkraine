class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_access, only: [:edit, :update]
  before_action :admin_user!, only: [:destroy]

  # GET /news
  # GET /news.json
  def index
    if user_signed_in? && current_user.admin?
      @news = News.unscoped
    else
      @news = News
    end

    @news = @news.paginate(page: params[:page]).order(created_at: :desc)
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @news = News.new
    @news.build_location
  end

  # GET /news/1/edit
  def edit
    @news.build_location unless @news.location
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)
    
    if user_signed_in?
      @news.user_id ||= current_user.id
      @news.status  ||= 'published'
    else
      @news.status = 'draft'
    end

    respond_to do |format|
      if @news.save
        if user_signed_in?
          format.html { redirect_to @news, notice: 'Новость успешно добавлена!' }
          format.json { render :show, status: :created, location: @news }
        else
          format.html { redirect_to root_path, notice: 'Новость успешно создана! Пожалуйста, дождитесь проверки.' }
          format.json { render :show, status: :created, location: @news }
        end
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    @news.update(news_params)
    @news.user_id ||= current_user.id unless current_user.admin?

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'Новость успешно отредактированна!' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'Новость успешно удалена!' }
      format.json { head :no_content }
    end
  end

  private
    # Check access to editing or removing news
    def check_access
      if !current_user.admin? && !current_user.author?(@news)
        redirect_to news_path, notice: 'Недостаточно прав для просмотра этой страницы'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_news
      if user_signed_in? && current_user.admin?
        @news = News.unscoped.find(params[:id])
      else
        @news = News.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      if user_signed_in? && current_user.admin?
        params.require(:news).permit(:user_id, :title, :description, :text, :status, :text, :youtube_url, :happened_at, location_attributes: [:address, :lat, :lng])
      else
        params.require(:news).permit(:title, :description, :text, :youtube_url, :happened_at, location_attributes: [:address, :lat, :lng])
      end
    end
end
