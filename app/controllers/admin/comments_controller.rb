module Admin
  class CommentsController < AdminController
    before_action :load_comment, only: %i(show destroy)

    def index
      @comments = Comment.by_select_comment.page(params[:page]).by_order
        .per Settings.per_page
    end

    def show; end

    def destroy
      if @comments.destroy
        flash[:success] = t ".comment_deleted"
      else
        flash[:danger] = t ".comment_no_delete"
      end
      redirect_to admin_comments_url
    end

    private

    def load_comment
      @comments = Comment.find_by id: params[:id]
      return if @comments
      flash[:danger] = t ".no_comment"
      redirect_to admin_comments.url
    end
  end
end
