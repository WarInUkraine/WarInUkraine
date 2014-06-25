class Admin::NewsController < Admin::AdminController
  before_action :set_news, only: [:edit, :update, :destroy]

  # GET /admin/news
  # GET /admin/news.json
  def index
    @news = News.unscoped.order(created_at: :desc)
  end

  # GET /admin/news/new
  def new
    @news = News.new
    @news.build_location
  end

  # GET /admin/news/1/edit
  def edit
    @news.build_location unless @news.location
  end

  # POST /admin/news
  # POST /admin/news.json
  def create
    @news = News.new(news_params)

    if @news.save
      redirect_to admin_news_index_path, notice: 'Новость успешно добавлена!'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/news/1
  # PATCH/PUT /admin/news/1.json
  def update
    if @news.update(news_params)
      redirect_to admin_news_index_path, notice: 'Новость успешно отредактированна!'
    else
      render :edit
    end
  end

  # DELETE /admin/news/1
  # DELETE /admin/news/1.json
  def destroy
    if @news.removed? || @news.draft?
      @news.destroy

      respond_to do |format|
        format.html { redirect_to admin_news_index_path, notice: 'Новость успешно удалена!' }
        format.json { head :no_content }
      end
    else
      @news.removed!

      respond_to do |format|
        format.html { redirect_to admin_news_index_path, notice: 'Новость успешно помечена как удаленная!' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.unscoped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:user_id, :title, :description, :text, :youtube_url, :youtube_data, :status, :happened_at, location_attributes: [:address, :lat, :lng])
    end
end
