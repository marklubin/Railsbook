require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = Product.new(title: 'title',
                          description: 'blah',
                          image_url: 'zzz.jpg',
                          price: -1)

    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0

    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test 'image url must be valid' do
    valid = %w(a.png b.jpg c.gif)
    valid.each do |image|
      product = new_product_with_img_url(image)
      assert product.valid?
    end

    product = new_product_with_img_url('notanimage.pdf')
    assert product.invalid?
    assert_equal ['must be a URL for a GIF, JPG or PNG'], product.errors[:image_url]
  end

  test 'product name must be unique' do
    product = Product.new(title: products(:ruby).title,
                          description: 'yyy', price: 1, image_url: 'fred.gif')
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  def new_product_with_img_url(image_url)
    Product.new(title: 'title',
                description: 'blah',
                price: 1,
                image_url: image_url)
  end
end
