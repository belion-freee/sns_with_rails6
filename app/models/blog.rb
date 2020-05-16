class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_rich_text :body

  validates :title, presence: true
  validates :body, presence: true

  scope :find_with_comments, -> (id) {
    includes(:favorites, comments: :user).find(id)
  }

  def has_favorites?(favorite_user)
    self.favorites.to_a.find {|favorite| favorite.user_id == favorite_user.id }.present?
  end

  def like(favorite_user_id)
    self.favorites.new(user_id: favorite_user_id).save!
  end

  def unlike(favorite_user_id)
    favorite_id = self.favorites.find_by(user_id: favorite_user_id).id
    self.favorites.destroy(favorite_id)
  end
end
