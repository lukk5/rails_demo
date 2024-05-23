class Product < ApplicationRecord
  # Validations
  validates :title, :description, :image_url, presence: { message: "must be provided" }
  validates :description, length: { in: 10..1000, message: "must be between 10 and 1000 characters" }
  validates :image_url, format: { with: /\Ahttps?:\/\/.+\.(png|jpg|jpeg)\z/i, message: "must be a URL for GIF, JPG, or PNG image." }
  validates :price, presence: { message: "must be provided" }, numericality: { greater_than_or_equal_to: 0.01, message: "must be greater than or equal to 0.01" }

  # Custom validation
  validate :price_must_be_positive

  private 

  def price_must_be_positive
    if price.nil? || price <= 0
      errors.add(:price, "must be greater than or equal to 0.01")
    end
  end
end
