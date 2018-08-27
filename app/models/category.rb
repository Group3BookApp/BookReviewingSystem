class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :authors, through: :books
  scope :by_category, -> {order :name}
  scope :search_cate, -> (search){
    where("name LIKE ?", "%#{search}%")
  }
  validates :name, presence: true, length: {maximum: Settings.post}
end
