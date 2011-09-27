require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product title must be more than 10 characters" do
    product = Product.new(title: "12345678",
                          description: "test",
                          image_url: "zzz.jpg",
                          price: 1)
    assert product.invalid?

    product[:title] = "1234567890"
    assert product.valid?
  end

  test "product price must be positive" do
    product = Product.new(title: "test test test",
                          description: "test",
                          image_url: "zzz.jpg")
    product.price = -1;
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')
    
    product.price = 0.01
    assert product.valid?
  end

  test "product title must be unique" do
    product = Product.new(title: products(:ruby).title,
                          description: "yyy",
                          price: 1,
                          image_url: "loser.gif")
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
                 product.errors[:title].join('; ')
  end
end
