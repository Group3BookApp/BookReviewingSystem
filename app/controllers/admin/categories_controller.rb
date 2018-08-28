module Admin
  class CategoriesController < AdminController
    before_action :load_category, only: %i(edit update destroy)

    def index
      @category = Category.page(params[:page]).per Settings.per_page
    end

    def create
      @category = Category.new category_params
      if @category.save
        flash[:success] = t ".created"
      else
        flash[:danger] = t ".createfalse"
      end
      redirect_to admin_categories_url
    end

    def edit; end

    def update
      if @category.update_attributes category_params
        flash[:success] = t ".updated"
        redirect_to admin_categories_url
      else
        render :edit
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = t ".deleted"
      else
        flash[:error] = t ".delete_fail"
      end
      redirect_to admin_categories_url
    end

    private

    def load_category
      @category = Category.find_by id: params[:id]
      return if @category
      flash[:danger] = t ".no_category"
      redirect_to admin_categories_url
    end

    def category_params
      params.require(:category).permit :name
    end
  end
end
