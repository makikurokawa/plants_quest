class Post < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(is_draft: false) }

  has_many :favorites, dependent: :destroy
  has_many_attached :images
  has_many :post_tags
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :post_tags, allow_destroy: true
  has_many :post_comments


  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end

  def self.search(search)
    if search
      where(['title LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  with_options presence: true, on: :publicize do
    validates :title
    validates :contents
  end
  validates :title, length: { maximum: 20 }, on: :publicize
end