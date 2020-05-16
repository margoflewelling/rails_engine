class Api::V1::MerchantsController < ApplicationController

  def index
    @data = Merchant.all
    render json: MerchantSerializer.new(@data).serializable_hash
  end

end
