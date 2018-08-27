class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  has_many :reviews, dependent: :destroy
  scope :by_order, -> {order created_at: :desc}
  scope :by_select_book, -> {
    select :id, :picture, :title, :num_page, :avg_rate, :description,
    :author_id, :category_id
  }
  mount_uploader :picture, PictureUploader
  validates :title, presence: true, length: {maximum: Settings.length_title_book}
  validates :num_page, presence: true
  validates :avg_rate, presence: true
  validates :description, presence: true, length: {maximum: Settings.length_description}
  validates :author_id, presence: true, length: {maximum: Settings.post}
  validates :category_id, presence: true, length: {maximum: Settings.post}
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :author, prefix: true, allow_nil: true
end
