class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_rich_text :body

  scope :find_with_comments, -> (id) {
    includes(comments: :user).find(id)
  }
end
