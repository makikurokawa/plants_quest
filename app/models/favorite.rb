class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
