class Admin::PagesController < Admin::AdminController
  before_action :set_page, only: [:edit, :update, :destroy]

  # GET /admin/pages
  # GET /admin/pages.json
  def index
    @pages = Static.all
  end

  # GET /admin/pages/new
  def new
    @page = Static.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  # POST /admin/pages.json
  def create
    @page = Static.new(page_params)

    if @page.save
      redirect_to admin_pages_path, notice: 'Страница успешно создана!'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  # PATCH/PUT /admin/pages/1.json
  def update
    if @page.update(page_params)
      redirect_to admin_pages_path, notice: 'Страница успешно обновлена!'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to admin_pages_url, notice: 'Страница успешно удалена!' }
      format.json { head :no_content }
    end
  end

  private
    def set_page
      @page = Static.find(params[:id])
    end

    def page_params
      params.require(:static).permit(:url, :title, :html)
    end
end
