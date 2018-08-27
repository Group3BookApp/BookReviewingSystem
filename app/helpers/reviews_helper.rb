module ReviewsHelper
  def correct_review? review
    review.user_id == current_user.id
  end
end
