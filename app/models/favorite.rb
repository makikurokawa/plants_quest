class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
