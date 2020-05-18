class Api::V1::Merchants::SearchController < ApplicationController

  def find
    possible_merchants = check_params(params)
    @merchant = possible_merchants.detect{ |merchant| possible_merchants.count(merchant) == @query_params }
    render json: MerchantSerializer.new(@merchant).serializable_hash
  end

  private

  def check_params(params)
    @query_params = 0
    possible_merchants = []
    params.each do |key, value|
      if merchant_attributes.include?(key)
        @query_params += 1
        possible_merchants << Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")
        possible_merchants = possible_merchants.flatten
      end
    end
    possible_merchants
  end


  def merchant_attributes
    ["name", "created_at", "updated_at"]
  end

end
