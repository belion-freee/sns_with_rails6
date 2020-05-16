class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_rich_text :body

  validates :title, presence: true
  validates :body, presence: true

  scope :find_with_comments, -> (id) {
    includes(comments: :user).find(id)
  }
end
