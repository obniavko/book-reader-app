class Book < ApplicationRecord
  validates :title, presence: true, length: { in: 1..150 }
  validates :author, presence: true, length: { in: 1..50 }
  validates :isbn, uniqueness: true, format: { with: /\A\d[\d-]*\d\z/,
    message: "only allows numbers and dashes" }, allow_blank: true
  validates :description, length: { maximum: 1000 }

  scope :ordered, -> { order(:title) }
end
