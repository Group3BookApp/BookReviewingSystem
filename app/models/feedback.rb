class Feedback < ApplicationRecord
  belongs_to :user
  delegate :name, to: :user
  scope :by_order, -> {order created_at: :desc}
  scope :by_select_feedback, -> {select :id, :content, :user_id}
  validates :content, presence: true, length: {maximum: Settings.length_description}
end
