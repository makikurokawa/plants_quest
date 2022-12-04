class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_tags, dependent: :destroy
  has_many_attached :image