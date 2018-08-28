class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  delegate :name, to: :user
  scope :by_order, -> {order created_at: :desc}
  scope :by_select_comment, -> {
    select :id, :content, :user_id, :review_id
  }
  validates :content, presence: true, length: {maximum: Settings.length_description}
  validates :user_id, presence: true, length: {maximum: Settings.post}
  validates :review_id, presence: true, length: {maximum: Settings.post}
end
