class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :authors, through: :books
  scope :by_category, -> {order :name}
  validates :name, presence: true, length: {maximum: Settings.post}
end
