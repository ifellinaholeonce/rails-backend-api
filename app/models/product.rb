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

class Product < ApplicationRecord
  belongs_to :shop
  has_many :line_items, dependent: :destroy, inverse_of: :product
  has_many :orders, through: :line_items

  validates :shop, :price, presence: true
end
