# frozen_string_literal: true

class Api::V1::OrdersController < ApiController
  before_action :set_shop
  before_action :set_order
  def show
    render json: OrderSerializer.new(@order).serialized_json
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_order
    @order = @shop.orders.find(params[:id])
  end
end
