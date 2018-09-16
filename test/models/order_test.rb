# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  shop_id    :integer
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @valid_order = orders(:valid_order)
    assert @valid_order.valid?
  end

  test 'it belongs to a shop' do
    @valid_order.shop = nil
    assert_not @valid_order.valid?
  end

  test 'it has a total_sum' do
    assert_equal @valid_order.total_sum, 10
  end
end
