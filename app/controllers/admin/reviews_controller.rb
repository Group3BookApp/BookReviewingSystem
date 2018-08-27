module Admin
  class ReviewsController < AdminController
    before_action :load_review, only: %i(show destroy)

    def index
      @reviews = Review.by_select_review.page(params[:page]).by_order
        .per Settings.per_page
    end

    def show; end

    def destroy
      if @reviews.destroy
        flash[:success] = t ".review_deleted"
      else
        flash[:danger] = t ".review_no_delete"
      end
      redirect_to admin_reviews_url
    end

    private

    def load_review
      @reviews = Review.find_by id: params[:id]
      return if @reviews
      flash[:danger] = t ".no_review"
      redirect_to admin_reviews_url
    end
  end
end
