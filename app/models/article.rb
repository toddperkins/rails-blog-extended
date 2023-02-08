class Article < ApplicationRecord

  has_many :comments

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  
  has_one_attached :article_image

  validate :acceptable_image

  def acceptable_image
    return unless article_image.attached?

    unless article_image.blob.byte_size <= 1.megabyte
      errors.add(:article_image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(article_image.content_type)
      errors.add(:article_image, "must be a JPEG or PNG")
    end
  end

end
