# frozen_string_literal: true

class Api::V1::ProductsController < ApiController
  before_action :set_shop
  before_action :set_product
  def show
    render json: ProductSerializer.new(@order).serialized_json
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_product
    @order = @shop.products.find(params[:id])
  end
end
