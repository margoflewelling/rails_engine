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
    merchants
  end


  # def find
  #   possible_merchants = check_params(params)
  #   merchant = possible_merchants.detect{ |merchant| possible_merchants.count(merchant) == @query_params }
  #   render json: MerchantSerializer.new(merchant).serialized_json
  # end

  # def find_all
  #   possible_merchants = check_params(params)
  #   merchants = possible_merchants.select{ |merchant| possible_merchants.count(merchant) == @query_params }.uniq
  #   render json: MerchantSerializer.new(merchants).serialized_json
  # end


end

#   def check_params(params)
#     @query_params = 0
#     possible_merchants = []
#     params.each do |key, value|
#       if merchant_attributes.include?(key)
#         @query_params += 1
#         possible_merchants << Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")
#         possible_merchants = possible_merchants.flatten
#       end
#     end
#     possible_merchants
#   end
#
#
#   def merchant_attributes
#     ["name", "created_at", "updated_at", "id"]
#   end
#
# end
