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
Order.destroy_all
LineItem.destroy_all

shop = Shop.new
shop.name = 'My Shop'
if shop.save
  puts 'shop saved'
else
  puts 'shop did not save'
end

10.times do |i|
  product = Product.new
  product.name = "My Product #{i}"
  product.description = 'My Product Description'
  product.count = rand(10..20)
  product.price = rand(5..15)
  product.shop = shop
  if product.save
    puts 'product saved'
  else
    puts 'product did not save'
  end
end

10.times do
  order = Order.new
  order.shop = shop
  order.save

  rand(2..6).times do |item|
    line_item = LineItem.new
    line_item.order = order
    line_item.product = Product.find(Product.first.id + item)
    line_item.save
  end
end