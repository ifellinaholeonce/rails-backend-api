# frozen_string_literal: true

class Api::V1::OrdersController < ApiController
  before_action :set_shop
  before_action :set_order, only: %i[show update]

  def index
    render json: OrderSerializer.new(@shop.orders.first(10))
                  .serialized_json
  end

  def show
    render json: OrderSerializer.new(@order).serialized_json
  end

  def create
    @order = @shop.orders.new(order_params)
    if @order.save
      add_line_items
      render json: OrderSerializer.new(@order).serialized_json
    else
      render json: @order.errors
    end
  end

  def update
    if @order.update(order_params)
      add_line_items
      render json: OrderSerializer.new(@order).serialized_json
    else
      render json: @order.errors
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_order
    @order = @shop.orders.find(params[:id])
  end

  def order_params
    params.permit(
      :status
    )
  end

  def add_line_items
    return if params[:product_ids].blank?
    @order.line_items.delete_all
    params[:product_ids].each do |id|
        @order.line_items.new(
        product: @shop.products.find(id),
      ).save
    end
  end
end