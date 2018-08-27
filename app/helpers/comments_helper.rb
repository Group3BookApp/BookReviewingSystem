module CommentsHelper
  def correct_comment? comment
    comment.user_id == current_user.id
  end
end
