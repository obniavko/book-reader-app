class Book < ApplicationRecord
  update_index('books') { self }

  has_one_attached :cover, dependent: :destroy
  has_one_attached :content, dependent: :destroy

  validates :title, presence: true, length: { in: 1..150 }
  validates :author, presence: true, length: { in: 1..50 }
  validates :isbn, presence: true, uniqueness: true, format: { with: /\A\d[\d-]*\d\z/ }
  validates :description, length: { maximum: 1000 }
  validates :cover, content_type: [:png, :jpg, :jpeg]
  validates :content, content_type: [:pdf]

  scope :ordered, -> { order(:title) }
end
