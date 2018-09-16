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

class Order < ApplicationRecord
  enum status: %i[unfinished unfulfilled fulfilled]
  belongs_to :shop, inverse_of: :orders
  has_many :line_items, dependent: :destroy, inverse_of: :order

  scope :unfinished, -> { where(status: 'unfinished') }
  scope :unfulfilled, -> { where(status: 'unfulfilled') }
  scope :fulfilled, -> { where(status: 'fulfilled') }
  def total_sum
    line_items.map(&:price).sum
  end

  def item_count
    line_items.size
  end
end
