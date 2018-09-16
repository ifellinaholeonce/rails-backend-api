# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id         :bigint(8)        not null, primary key
#  product_id :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  setup do
    @valid_item = line_items(:valid_item)
    @valid_product = products(:valid_product)
    assert @valid_item.valid?
  end

  test 'it belongs to a product' do
    @valid_item.product = nil
    assert_not @valid_item.valid?
  end

  test 'it belongs to an order' do
    @valid_item.order = nil
    assert_not @valid_item.valid?
  end

  test 'it has a price that matches the price of the product' do
    assert_equal @valid_item.price, @valid_item.product.price
    assert_equal @valid_item.price, @valid_product.price
  end
end
