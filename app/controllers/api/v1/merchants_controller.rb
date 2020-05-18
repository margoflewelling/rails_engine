class Api::V1::MerchantsController < ApplicationController

  def index
    data = Merchant.all
    render json: MerchantSerializer.new(data).serialized_json
  end

  def show
    merchant = Merchant.find(params["id"])
    render json: MerchantSerializer.new(merchant).serialized_json
  end

  def create
    merchant = Merchant.create(merchant_params)
    render json: MerchantSerializer.new(merchant).serialized_json
  end

  def destroy
    merchant = Merchant.find(params["id"])
    render json: MerchantSerializer.new(merchant.delete).serialized_json
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params)).serialized_json
  end

private

  def merchant_params
    params.permit(:name)
  end

end
