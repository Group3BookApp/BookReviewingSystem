class CommentsController < ApplicationController
  before_action :load_book
  before_action :load_review
  before_action :load_comment, except: :create
  before_action :logged_in_user, only: %i(create edit update destroy)
  before_action :correct_comment, only: :update
  before_action :check_user_comment, only: :destroy

  def show; end

  def edit; end

  def create
    @comment = @review.comments.new comment_params
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = t ".success"
    else
      flash[:error] = t ".create_failed"
    end
    redirect_to book_path @book
  end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = t ".updated"
    else
      flash[:danger] = t ".update_failed"
    end
    redirect_to book_path @book
  end

  def destroy
    if @comment.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to book_path @book
  end

  private

  def load_book
    return if @book = Book.find_by(id: params[:comment][:book_id])
    flash[:danger] = t ".not_found"
    redirect_to books_path
  end

  def load_review
    return if @review = Review.find_by(id: params[:comment][:review_id])
    flash[:danger] = t ".not_found"
    redirect_to book_path @book
  end

  def load_comment
    return if @comment = Comment.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to book_path @book
  end

  def comment_params
    params.require(:comment).permit :content
  end

  def correct_comment
    return if correct_comment? comment
    flash[:danger] = t ".unauthorized"
    redirect_to book_path @book
  end

  def check_user_comment
    return if current_user.admin? || correct_review?(@comment)
    flash[:danger] = t ".unauthorized"
    redirect_to book_path @book
  end
end
