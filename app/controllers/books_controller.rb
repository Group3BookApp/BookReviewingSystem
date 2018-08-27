class BooksController < ApplicationController
  before_action :load_book
  before_action :load_review
  def index
    @feed_items = Book.page(params[:page]).per Settings.per_page
  end

  def show
    @book_reviews = @book.reviews.by_order.select_5
    @comment = Comment.new
    #byebug
    @review_comments = @review.comments.by_order.select_5
  end

  private

  def load_book
    return if @book = Book.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to books_path
  end

  def load_review
    return if @review = Review.find_by(id: params[:id])
    #flash[:danger] = "Not found"
    redirect_to book_path @book
  end
end
