class BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    @feed_items = Book.page(params[:page]).per Settings.per_page
  end

  def show
    if Mark.where(user_id: current_user.id).where(book_id: @book.id).count > 0 
      @mark = Mark.where(user_id: current_user.id).where(book_id: @book.id).first
    else 
      @mark = @book.marks.build
    end
    @book_reviews = @book.reviews.by_order.select_5
  end

  private

  def load_book
    return if @book = Book.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to books_path
  end
end
