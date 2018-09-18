# frozen_string_literal: true

class LineItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :shop_id, :order_id, :product_id, :price
  belongs_to :order
  belongs_to :product
end
