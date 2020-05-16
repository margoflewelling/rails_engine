class Api::V1::MerchantsController < ApplicationController

  def index
    @data = Merchant.all
    render json: MerchantSerializer.new(@data).serializable_hash
  end

  def create
    @merchant = Merchant.create(merchant_params)
    render json: MerchantSerializer.new(@merchant).serializable_hash
  end

  def destroy
    @merchant = Merchant.find(params["id"])
    require "pry"; binding.pry
    render json: MerchantSerializer.new(@merchant.delete).serializable_hash
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params)).serializable_hash
  end

private

  def merchant_params
    params.require(:merchant).permit(:name)
  end

end
