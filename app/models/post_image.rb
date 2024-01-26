class PostImage < ApplicationRecord
  enum media_type: {
    image: 0,
    video: 1
  }

  belongs_to :post
end
