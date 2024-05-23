class Product < ApplicationRecord
  # Validations
  validates :title, :description, presence: { message: "must be provided" }
  validates :description, length: { in: 10..1000, message: "must be between 10 and 1000 characters" }
  validates :image_url, format: { with: /\Ahttps?:\/\/.+\.(png|jpg|jpeg)\z/i, message: "must be a URL for GIF, JPG, or PNG image." }, if: -> { image_url.present? }

  # Custom validation
  validate :price_must_be_positive

  private 

  def price_must_be_positive
    if price.nil? || price <= 0
      errors.add(:price, "must be greater than or equal to 0.01")
    end
  end
end
