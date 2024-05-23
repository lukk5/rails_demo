require 'rails_helper'

RSpec.describe Product, type: :model do
    describe 'validations' do
        it 'is valid with valid attributes' do
            product = Product.new(
                title: 'Example Product',
                price: 9.99,
                description: 'This is an example product',
                image_url: 'https://example.com/example.jpg'
            )
            expect(product).to be_valid
        end

        it 'is invalid without a title' do
            product = Product.new(title: nil)
            product.valid?
            expect(product.errors[:title]).to include("must be provided")
        end

        it 'is invalid without a price' do
            product = Product.new(price: nil)
            product.valid?
            expect(product.errors[:price]).to include("must be greater than or equal to 0.01")
        end

        it 'is invalid without a description' do
            product = Product.new(description: nil)
            product.valid?
            expect(product.errors[:description]).to include("must be provided")
        end


        it 'is invalid with a description less than 10 characters' do
            product = Product.new(description: 'Too short')
            product.valid?
            expect(product.errors[:description]).to include("must be between 10 and 1000 characters")
        end

        it 'is invalid with a description more than 1000 characters' do
            product = Product.new(description: 'a' * 1001)
            product.valid?
            expect(product.errors[:description]).to include("must be between 10 and 1000 characters")
        end

        it "is invalid with an image_url that is not a valid URL" do
            product = Product.new(image_url: "not_a_url")
            product.valid?
            expect(product.errors[:image_url]).to include("must be a URL for GIF, JPG, or PNG image.")
          end
      
          it "is valid with a nil image_url" do
            product = Product.new(
                title: 'Example Product',
                price: 9.99, # This is negative
                description: 'This is an example product',
                image_url: nil
              )
            expect(product).to be_valid
          end
      
          it "is valid with a valid image_url" do
            product = Product.new(
              title: 'Example Product',
              price: 9.99, # This is negative
              description: 'This is an example product',
              image_url: 'https://example.com/example.jpg'
            )
            expect(product).to be_valid
          end

        it 'is valid with a positive price' do
            product = Product.new(
              title: 'Example Product',
              price: 9.99,
              description: 'This is an example product',
              image_url: 'https://example.com/example.jpg'
            )
            expect(product).to be_valid
          end

          it 'is invalid with a negative price' do
            product = Product.new(
              title: 'Example Product',
              price: -9.99, # This is negative
              description: 'This is an example product',
              image_url: 'https://example.com/example.jpg'
            )
            product.valid?
            expect(product.errors[:price]).to include("must be greater than or equal to 0.01")
          end
    end
end