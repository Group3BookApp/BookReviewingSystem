class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :title, to: :user, prefix: true, allow_nil: true
  scope :by_select_review, -> {
    select :id, :content, :num_rate, :user_id, :book_id, :created_at
  }
  scope :by_order, -> {order created_at: :desc}
  scope :select_5, -> {take Settings.select_5}
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.length_content_review}
end