class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = User.all
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'Пользователь успешно создан!'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    user_update_params = user_params

    if user_update_params[:password].empty?
      user_update_params.delete(:password)
      user_update_params.delete(:password_confirmation)
    end

    if @user.update(user_update_params)
      redirect_to admin_users_path, notice: 'Пользователь успешно отредактирован!'
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    if @user.id == 1 || @user.email == 'warinukraine.info@gmail.com'
      redirect_to admin_users_path, flash: { error: 'Воу Воу Воу! Парень палехче ;)' } and return
    end

    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'Пользователь успешно удален!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :first_name, :last_name, :about)
    end
end
