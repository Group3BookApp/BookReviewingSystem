class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  scope :by_order, -> {order created_at: :desc}
  scope :by_select_book, -> {select(:id, :picture, :title, :num_page, :avg_rate, :description,:author_id, :category_id)}
  mount_uploader :picture, PictureUploader
  validates :title, presence: true, length: {maximum: Settings.post}
  validates :num_page, presence: true, length: {maximum: Settings.post}
  validates :avg_rate, length: {maximum: Settings.length_rate}
  validates :description, presence: true, length: {maximum: Settings.length_description}
  validates :author_id, presence: true, length: {maximum: Settings.post}
  validates :category_id, presence: true, length: {maximum: Settings.post}
end
