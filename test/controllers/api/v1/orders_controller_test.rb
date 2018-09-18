# frozen_string_literal: true

require 'test_helper'

class Api
  class V1
    class OrdersControllerTest < ActionDispatch::IntegrationTest
      setup do
        @valid_shop = shops(:valid_shop)
        @valid_order = orders(:valid_order)
      end

      class GetShow < OrdersControllerTest
        test 'it returns order JSON #show' do
          get api_v1_shop_order_path(@valid_shop, @valid_order)
          json = JSON.parse(response.body)
          assert_equal json['data']['type'], 'order'
        end
      end

      class GetIndex < OrdersControllerTest
        test 'it returns a list of orders JSON #index' do
          get api_v1_shop_orders_path(@valid_shop)
          json = JSON.parse(response.body)
          assert_equal json['data'][0]['type'], 'order'
          assert_equal @valid_shop.orders.size, json['data'].count
        end
      end

      class PostIndex < OrdersControllerTest
        test 'it can create order' do
          assert_difference('@valid_shop.orders.count', 1) do
            post api_v1_shop_orders_path(@valid_shop,
                                         status: 'unfulfilled',
                                         product_ids: [@valid_shop.products.first, @valid_shop.products.second])
          end
          json = JSON.parse(response.body)
          assert_equal json['data']['type'], 'order'
          assert_equal json['data']['attributes']['total_sum'], 15
        end
      end

      class PatchUpdate < OrdersControllerTest
        test 'it can update a order' do
          assert_difference('@valid_shop.orders.count', 0) do
            put api_v1_shop_order_path(@valid_shop, @valid_order,
              {
                product_ids: [@valid_shop.products.first]
              }
            )
          end
          @valid_order.reload
          assert_equal 1, @valid_order.line_items.size
          assert_equal @valid_order.total_sum, 5
        end
      end
    end
  end
end
