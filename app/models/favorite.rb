class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validetes :user_id, uniqueness: { scope: :blog_id }
end
