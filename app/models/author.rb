class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  scope :by_author, -> {order :name}
  validates :name, presence: true, length: {maximum: Settings.post}
end
