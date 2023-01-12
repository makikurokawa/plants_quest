class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many_attached :images
  has_many :tags, inverse_of: :event, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true
  validates_associated :tags


  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end