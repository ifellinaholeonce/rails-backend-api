# frozen_string_literal: true

require 'test_helper'

class Api
  class V1
    class LineItemsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @valid_shop = shops(:valid_shop)
        @shop_two = shops(:valid_shop_two)
        @valid_product = products(:valid_product)
        @valid_order = orders(:valid_order_two)
        @valid_item = line_items(:valid_item)
        @valid_item_two = line_items(:valid_item_two)
      end

      class GetShow < LineItemsControllerTest
        test 'it returns line item JSON #show' do
          get api_v1_shop_product_line_item_path(@valid_shop, @valid_product, @valid_item)
          json = JSON.parse(response.body)
          assert_equal json['data']['type'], 'line_item'
        end
      end

      class GetIndex < LineItemsControllerTest
        test 'it returns a list of line item JSON #index' do
          get api_v1_shop_product_line_items_path(@valid_shop, @valid_product)
          json = JSON.parse(response.body)
          assert_equal json['data'][0]['type'], 'line_item'
          assert_equal @valid_product.line_items.size, json['data'].count
        end
      end

      class Delete < LineItemsControllerTest
        test 'it can delete line item' do
          assert_difference(['@valid_order.line_items.count', '@valid_product.line_items.count'], -1) do
            delete api_v1_shop_order_line_item_path(
              @shop_two,
              @valid_order,
              @valid_item_two
              )
          end
          json = JSON.parse(response.body)
          assert_equal json['data'][0]['type'], 'line_item'
          assert_equal @valid_order.line_items.size, json['data'].count
        end
      end
    end
  end
end
