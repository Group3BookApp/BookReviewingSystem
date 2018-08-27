class ReviewsController < ApplicationController
  before_action :load_book, only: %i(create update destroy)
  before_action :load_review, except: :create
  before_action :logged_in_user, only: %i(create edit update destroy)
  before_action :correct_review, only: :update
  before_action :check_user_review, only: :destroy

  def show; end

  def edit; end

  def create
    @review = @book.reviews.new review_params
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = t ".success"
      redirect_to book_path @book
    else
      flash[:danger] = t ".error"
      redirect_to book_path @book
    end
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t ".updated"
    else
      flash[:danger] = t ".update_failed"
    end
    redirect_to book_path @book
  end

  def destroy
    if @review.destroy
      flash[:success] = t ".deleted"
    else
      flash[:error] = t ".delete_failed"
    end
    redirect_to book_path @book
  end

  private

  def review_params
    params.require(:review).permit :content
  end

  def load_book
    return if @book = Book.find_by(id: params[:book_id])
    flash[:danger] = t ".not_found"
    redirect_to books_path
  end

  def load_review
    return if @review = @book.reviews.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to book_path @book
  end

  def correct_review
    return if correct_review? @review
    flash[:danger] = t ".unauthorized"
    redirect_to book_path @book
  end

  def check_user_review
    return if current_user.admin? || correct_review?(@review)
    flash[:danger] = t ".unauthorized"
    redirect_to book_path @book
  end
end
