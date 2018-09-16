# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :shop_id, index: true
      t.integer :status, index: true, default: 0

      t.timestamps
    end
  end
end
