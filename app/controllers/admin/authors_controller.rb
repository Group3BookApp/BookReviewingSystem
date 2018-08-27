module Admin
  class AuthorsController < AdminController
    before_action :load_author, only: %i(edit update destroy)

    def index
      if params[:search]
        @author = Author.search_name(params[:search]).page(params[:page]).per Settings.per_page
      else
        @author = Author.page(params[:page]).per Settings.per_page
      end
    end

    def create
      @author = Author.new author_params
      if @author.save
        flash[:success] = t ".created"
      else
        flash[:danger] = t ".createfalse"
      end
      redirect_to admin_authors_url
    end

    def edit; end

    def update
      if @author.update_attributes author_params
        flash[:success] = t ".updated"
        redirect_to admin_authors_url
      else
        render :edit
      end
    end

    def destroy
      if @author.destroy
        flash[:success] = t ".deleted"
      else
        flash[:error] = t ".delete_fail"
      end
      redirect_to admin_authors_url
    end

    private

      def load_author
        @author = Author.find_by id: params[:id]
        return if @author
        flash[:danger] = t ".no_author"
        redirect_to admin_authors_url
      end

      def author_params
        params.require(:author).permit :name
      end
  end
end
