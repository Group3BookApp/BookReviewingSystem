class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  delegate :name, to: :user, prefix: true, allow_nil: true
  scope :by_order, -> {order created_at: :desc}
  scope :select_5, -> {take Settings.select_5}
  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.length_content_review}
end
