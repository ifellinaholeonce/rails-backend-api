# frozen_string_literal: true

class Api::V1::ShopsController < ApiController
  before_action :set_shop
  def show
    render json: ShopSerializer.new(@shop).serialized_json
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
