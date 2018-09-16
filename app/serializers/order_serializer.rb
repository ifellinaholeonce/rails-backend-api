# frozen_string_literal: true

class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status, :total_sum, :item_count
  belongs_to :shop
  has_many :line_items
end
