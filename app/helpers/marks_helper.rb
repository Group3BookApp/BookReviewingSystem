module MarksHelper
  def correct_mark? mark
    mark.user_id == current_user.id
  end
end
