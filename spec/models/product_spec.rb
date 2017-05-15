require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:each) do
      @category = Category.new
    end
    
    it 'must have all 4 fields' do
      @product = @category.products.new(name: 'testName', price_cents: 10, quantity: 3)
      expect(@product).to be
    end

    it 'must have a valid name' do
      @product = @category.products.new(name: 'testName')
      expect(@product.name).not_to be_empty
    end

    it 'must have a valid price of more than 1' do
      @product = @category.products.new(price_cents: 1)
      expect(@product.price_cents).not_to be(nil)
      expect(@product.price_cents).not_to be == 0
    end

    it 'must have a valid quantity of more than 1' do
      @product = @category.products.new(quantity: 5)
      expect(@product.quantity).not_to be(nil)
      expect(@product.quantity).not_to be == 0
    end

    it 'must belong to a category' do
      expect(@category).not_to be(nil)
    end

  end
end
