module Admin
  class BooksController < AdminController
    before_action :load_book, only: %i(edit update destroy)
    before_action :load_author_category, only: %i(index edit)

    def index
      if params[:search]
        @books = Book.search_book(params[:search]).by_select_book.page(params[:page])
          .by_order.per Settings.per_page
      else
        @books = Book.by_select_book.page(params[:page]).by_order.per Settings.per_page
      end
    end

    def edit; end

    def update
      if @books.update_attributes book_params
        flash[:success] = t ".book_updated"
        redirect_to admin_books_url
      else
        render :edit
      end
    end

    def create
      @books = Book.new book_params
      if @books.save
        flash[:success] = t ".book_created"
      else
        flash[:danger] = t ".book_no_created"
      end
      redirect_to admin_books_url
    end

    def destroy
      if @books.destroy
        flash[:success] = t ".book_deleted"
      else
        flash[:danger] = t ".book_no_deleted"
      end
      redirect_to admin_books_url
    end

    private

    def load_book
      @books = Book.find_by id: params[:id]
      return if @books
      flash[:danger] = t ".no_book"
      redirect_to admin_books_url
    end

    def book_params
      params.require(:book).permit :title, :num_page, :description,
        :author_id, :category_id, :picture
    end

    def load_author_category
      @category_name = Category.by_category
      @author_name = Author.by_author
    end
  end
end
