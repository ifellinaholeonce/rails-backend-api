# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  description :string
#  count       :integer          default(0)
#  status      :integer          default(0)
#  shop_id     :integer
#  price       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @valid_product = products(:valid_product)
  end

  test 'it belongs to a shop' do
    assert @valid_product.valid?
    @valid_product.shop = nil
    assert_not @valid_product.valid?
  end

  test 'it has a price' do
    assert @valid_product.valid?
    @valid_product.price = nil
    assert_not @valid_product.valid?
  end
end
