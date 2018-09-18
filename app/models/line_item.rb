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

class LineItem < ApplicationRecord
  belongs_to :product, inverse_of: :line_items
  belongs_to :order, inverse_of: :line_items

  def price
    product.price
  end

  def shop_id
    product.shop.id
  end
end
