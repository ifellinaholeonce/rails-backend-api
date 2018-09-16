# frozen_string_literal: true

# == Schema Information
#
# Table name: shops
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Shop < ApplicationRecord
  has_many :products, dependent: :destroy, inverse_of: :shop
  has_many :orders, dependent: :destroy, inverse_of: :shop

  def total_orders
    orders.size
  end

  def unfulfilled_orders_count
    orders.unfulfilled.count
  end

  def unfinished_orders_count
    orders.unfinished.count
  end

  def fulfilled_orders_count
    orders.fulfilled.count
  end
end
