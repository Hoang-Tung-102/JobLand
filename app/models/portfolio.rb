class Portfolio < ApplicationRecord
	belongs_to :cv
	has_many_attached :images, dependent: :destroy
	validates :cv_id, presence: true
	validates :link, url: { allow_blank: true }
	validates :description, presence: true
	validates :title, presence: true
	validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
               message: "must be a valid image format" },
               size: { less_than: 5.megabytes,
               message: "should be less than 5MB" }

  # def display_image
  #   image.variant(resize_to_limit: [250, 250])
  # end
end
