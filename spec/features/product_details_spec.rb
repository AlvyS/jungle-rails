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

  scenario 'they click on a product details button' do
    visit '/products'
    save_screenshot('products-page.png')
    first('article.product').find_link('Details').click
    sleep(3)
    save_screenshot('product-details-page.png')

  end

end
