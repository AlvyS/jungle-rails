require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'they click on a products add to cart button' do
    visit '/products'
    save_screenshot('add-to-cart-before.png')
    first('article.product').find_link('Add').click
    sleep(1)
    save_screenshot('add-to-cart-after.png')

  end

end