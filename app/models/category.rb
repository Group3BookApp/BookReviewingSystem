class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  scope :by_category, -> {order :name}
  validates :name, presence: true, length: {maximum: Settings.post}
end
