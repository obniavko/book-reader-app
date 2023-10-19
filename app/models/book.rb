class Book < ApplicationRecord
  scope :ordered, -> { order(title: :asc) }

  validates :title, presence: true, length: { maximum: 150 }
  validates :author, presence: true
  validates :isbn, uniqueness: true, format: { with: /\A\d[\d-]*\d\z/,
    message: "only allows numbers and dashes" }
  validates :description, presence: true, length: { maximum: 1000 }
end
