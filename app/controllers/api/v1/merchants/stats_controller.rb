class Api::V1::Merchants::StatsController < ApplicationController

  def merchants_most_revenue
    merchants = Merchant.most_revenue(params["quantity"])
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def merchants_most_items
    merchants = Merchant.most_items(params["quantity"])
    require "pry"; binding.pry
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def revenue
    merchant = Merchant.find(params["id"])
    merch = merchant.revenue
    render json: MerchantRevenueSerializer.new(merch).serialized_json

  end

end
