# frozen_string_literal: true

class Api::V1::LineItemsController < ApiController
  before_action :set_shop
  before_action :set_target

  def index
    render json:  LineItemSerializer.new(@target.line_items.first(10)
                                      ).serialized_json
  end

  def show
    render json: LineItemSerializer.new(@target.line_items.find(params[:id])
                                    ).serialized_json
  end

  def create
    @product = @shop.products.new(product_params)
    if @product.save
      render json: ProductSerializer.new(@product).serialized_json
    else
      render json: @product.errors.full_messages
    end
  end

  def update
    if @product.update(product_params)
      render json: ProductSerializer.new(@product).serialized_json
    else
      render json: @product.errors
    end
  end

  def destroy
    @target.line_items.find(params[:id]).delete
    render json:  LineItemSerializer.new(@target.line_items.first(10)
                                  ).serialized_json
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_target
    @target = @shop.products.find(params[:product_id]) if params[:product_id].present?
    @target = @shop.orders.find(params[:order_id]) if params[:order_id].present?
  end
end
