class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many_attached :images
  has_many :post_tags
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :post_tags, allow_destroy: true
  has_many :post_comments


  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end
  
  with_options presence: true, on: :publicize do
    validates :title
    validates :contents
  end
  validates :title, length: { maximum: 20 }, on: :publicize
end