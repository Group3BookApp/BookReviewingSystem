class MarksController < ApplicationController
  before_action :load_mark, except: :create
  before_action :logged_in_user, only: %i(create edit update)

  def show; end

  def edit; end

  def create
    @book = Book.find_by id: params[:book_id]
    if @book
      @mark = @book.marks.new mark_params
      @mark.user_id = current_user.id
      if @mark.save
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
    if @mark.update_attributes mark_params
      flash[:success] = t ".updated"
    else
      flash[:danger] = t ".update_failed"
    end
    redirect_to book_path @book
  end

  private

  def mark_params
    params.require(:mark).permit :status
  end

  def load_mark
    if @book = Book.find_by(id: params[:book_id])
      return if @mark = @book.marks.find_by(id: params[:id])
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
