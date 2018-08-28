class CategoryBooksController < ApplicationController
  before_action :load_category, except: :create
  before_action :logged_in_user, only: %i(create edit update)

  def show; end

  def edit; end

  def create
    @book = Book.find_by id: params[:book_id]
    if @book
      @category = @book.marks.new category_params
      @category.user_id = current_user.id
      if @category.save
        flash[:success] = t ".success"
        redirect_to book_path @book
      else
        flash[:danger] = t ".error"
        redirect_to book_path @book
      end
    else
      flash[:danger] = "not_found"
      redirect_to books_path
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".updated"
    else
      flash[:danger] = t ".update_failed"
    end
    redirect_to book_path @book
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    if @book = Book.find_by(id: params[:book_id])
      return if @category = @book.categories.find_by(id: params[:id])
      flash[:danger] = t ".not_found"
      redirect_to book_path @book
    else
      flash[:danger] = t ".not_found"
      redirect_to books_path
    end
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".login_request"
    redirect_to login_url
  end
end
