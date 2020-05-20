class Api::V1::Merchants::SearchController < ApplicationController

  def find
    merchants = check_params(params)
    render json: MerchantSerializer.new(merchants.first).serialized_json
  end

  def find_all
    merchants = check_params(params)
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  private

  def check_params(params)
    merchants = Merchant.all
    merchants = merchants.filter_by_name(params[:name]) if params[:name].present?
    merchants = merchants.filter_by_id(params[:id]) if params[:id].present?
    merchant = merchant.filter_by_created_at(params[:created_at]) if params[:created_at.present?]
    merchant = merchant.filter_by_updated_at(params[:updated_at]) if params[:updated_at.present?]
    merchants
  end

end
