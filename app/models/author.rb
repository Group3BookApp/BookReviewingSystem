class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :categories, through: :books
  scope :by_author, -> {order :name}
  scope :search_name, -> (search){
    where("name LIKE ?", "%#{search}%")
  }
  validates :name, presence: true, length: {maximum: Settings.post}
end
