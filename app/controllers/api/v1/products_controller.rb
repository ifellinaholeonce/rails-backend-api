# frozen_string_literal: true

class Api::V1::ProductsController < ApiController
  before_action :set_shop
  before_action :set_product, only: %i[show update]

  def index
    render json: ProductSerializer.new(@shop.products.first(10))
                                  .serialized_json
  end

  def show
    render json: ProductSerializer.new(@product).serialized_json
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

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_product
    @product = @shop.products.find(params[:id])
  end

  def product_params
    params.permit(
      :name,
      :description,
      :price,
      :count
    )
  end
end
