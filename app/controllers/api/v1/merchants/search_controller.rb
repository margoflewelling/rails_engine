class Api::V1::Merchants::SearchController < ApplicationController

  def show
    @merchant = Merchant.find(params["id"])
    render json: MerchantSerializer.new(@merchant).serializable_hash
  end

end
