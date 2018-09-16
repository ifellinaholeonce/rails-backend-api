# frozen_string_literal: true

require 'test_helper'

class Api
  class V1
    class ShopsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @valid_shop = shops(:valid_shop)
      end

      class GetShow < ShopsControllerTest
        test 'it returns shop JSON #show' do
          get api_v1_shop_path(@valid_shop)
          json = JSON.parse(response.body)
          assert_equal json['data']['type'], 'shop'
        end
      end
    end
  end
end
