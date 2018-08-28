class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  scope :by_category, -> {order :name}
  scope :list, -> {select(:id, :title, :description).order(title: :asc)}
  scope :by_title, ->(cat_name){select(:id, :title, :description).order(title: :asc)
    .where("title like ?", "%#{cat_name}%")}
  validates :name, presence: true, length: {maximum: Settings.post}
end
