module Admin
  class FeedbacksController < AdminController
    before_action :load_feedback, only: %i(show destroy)

    def index
      @feedbacks = Feedback.by_select_feedback.page(params[:page]).by_order
        .per Settings.per_page
    end

    def show; end

    def destroy
      if @feedbacks.destroy
        flash[:success] = t ".feedback_deleted"
      else
        flash[:danger] = t ".feedback_no_delete"
      end
      redirect_to admin_feedbacks_url
    end

    private

    def load_feedback
      @feedbacks = Feedback.find_by id: params[:id]
      return if @feedbacks
      flash[:danger] = t ".no_feedback"
      redirect_to admin_feedbacks_url
    end
  end
end
