# frozen_string_literal: true

class ShopSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :total_orders, :unfulfilled_orders_count, :unfinished_orders_count, :fulfilled_orders_count
  has_many :products, dependent: :destroy, inverse_of: :shop
  has_many :orders, dependent: :destroy, inverse_of: :shop
end
