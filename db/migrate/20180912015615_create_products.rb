# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.integer :count, default: 0
      t.integer :status, index: true, default: 0
      t.integer :shop_id, index: true
      t.integer :price, default: 0

      t.timestamps
    end
  end
end
