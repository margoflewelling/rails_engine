class Api::V1::Items::SearchController < ApplicationController

  def find
    items = check_params(params)
    render json: ItemSerializer.new(items.first).serialized_json
  end

  def find_all
    items = check_params(params)
    render json: ItemSerializer.new(items).serialized_json
  end

  private

  def check_params(params)
    items = Item.all
    items = items.filter_by_name(params[:name]) if params[:name].present?
    items = items.filter_by_id(params[:id]) if params[:id].present?
    items = items.filter_by_description(params[:description]) if params[:description].present?
    items = items.filter_by_unit_price(params[:unit_price]) if params[:unit_price].present?
    items = items.filter_by_merchant_id(params[:merchant_id]) if params[:merchant_id].present?
    items = items.filter_by_created_at(params[:created_at]) if params[:created_at.present?]
    items = items.filter_by_updated_at(params[:updated_at]) if params[:updated_at.present?]
    items
  end

end
