# frozen_string_literal: true

class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :shop_id, :name, :description, :count, :price
  belongs_to :shop
  has_many :line_items, dependent: :destroy, inverse_of: :product
  has_many :orders, through: :line_items
end
