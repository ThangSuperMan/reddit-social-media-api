class Post < ApplicationRecord
  belongs_to :user

  has_many :post_images
end
