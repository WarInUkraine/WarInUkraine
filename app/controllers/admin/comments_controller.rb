class Admin::CommentsController < Admin::AdminController
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /admin/comments
  # GET /admin/comments.json
  def index
    @comments = Comment.unscoped.order(created_at: :desc)
  end

  # GET /admin/comments/1/edit
  def edit
  end

  # PATCH/PUT /admin/comments/1
  def update
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: 'Комменарий успешно отредактирован!'
    else
      render :edit
    end
  end

  # DELETE /admin/comments/1
  # DELETE /admin/comments/1.json
  def destroy
    if @comment.removed? || @comment.draft?
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to admin_comments_path, notice: 'Комменарий успешно удален!' }
        format.json { head :no_content }
      end
    else
      @comment.removed!

      respond_to do |format|
        format.html { redirect_to admin_comments_path, notice: 'Комменарий успешно отмечен как удаленный!' }
        format.json { head :no_content }
      end
    end


  end

  private
    def set_comment
      @comment = Comment.unscoped.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:email, :author, :author_id, :author_location, :text, :status)
    end
end
