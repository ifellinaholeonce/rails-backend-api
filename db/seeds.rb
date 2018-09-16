# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shop.destroy_all
Product.destroy_all
shop = Shop.new
shop.name = 'My Shop'
if shop.save
  puts 'shop saved'
else
  puts 'shop did not save'
end

2.times do |i|
  product = Product.new
  product.name = "My Product #{i}"
  product.description = 'My Product Description'
  product.count = 10
  product.price = 5
  product.shop = shop
  if product.save
    puts 'product saved'
  else
    puts 'product did not save'
  end
end

order = Order.new
order.shop = shop
order.save

line_item_one = LineItem.new
line_item_one.order = order
line_item_one.product = Product.first
line_item_one.save

line_item_two = LineItem.new
line_item_two.order = order
line_item_two.product = Product.second
line_item_two.save
