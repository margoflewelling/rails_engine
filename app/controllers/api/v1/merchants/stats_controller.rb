class Api::V1::Merchants::StatsController < ApplicationController

  def merchants_most_revenue
    merchants = Merchant.most_revenue(params["quantity"])
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def merchants_most_items
    merchants = Merchant.most_items(params["quantity"])
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def revenue
    merchant = Merchant.find(params["id"])
    merch = merchant.merchant_revenue(merchant.id)
    render json: RevenueSerializer.new(merch.first).serialized_json
  end



end
