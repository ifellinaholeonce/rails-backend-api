# frozen_string_literal: true

require 'test_helper'

class Api
  class V1
    class ProductsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @valid_shop = shops(:valid_shop)
        @valid_product = products(:valid_product)
      end

      class GetShow < ProductsControllerTest
        test 'it returns product JSON #show' do
          get api_v1_shop_product_path(@valid_shop, @valid_product)
          json = JSON.parse(response.body)
          assert_equal json['data']['type'], 'product'
        end
      end

      class GetIndex < ProductsControllerTest
        test 'it returns a list of products JSON #index' do
          get api_v1_shop_products_path(@valid_shop)
          json = JSON.parse(response.body)
          assert_equal json['data'][0]['type'], 'product'
          assert_equal @valid_shop.products.size, json['data'].count
        end
      end

      class PostIndex < ProductsControllerTest
        test 'it can create product' do
          assert_difference('@valid_shop.products.count', 1) do
            post api_v1_shop_products_path(@valid_shop,
                                           name: 'My Product',
                                           description: 'My Description',
                                           price: 10,
                                           count: 10)
          end
          json = JSON.parse(response.body)
          assert_equal json['data']['type'], 'product'
          assert_equal json['data']['attributes']['name'], 'My Product'
        end
      end

      class PatchUpdate < ProductsControllerTest
        test 'it can update a product' do
          assert_difference('@valid_shop.products.count', 0) do
            put api_v1_shop_product_path(@valid_shop, @valid_product,
                                         price: 15,
                                         count: 12)
          end
          @valid_product.reload
          assert_equal @valid_product.price, 15
        end
      end
    end
  end
end
