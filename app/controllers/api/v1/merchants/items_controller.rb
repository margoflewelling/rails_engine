class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    merchant_items = Item.where(merchant_id: params["id"].to_i)
    render json: ItemSerializer.new(merchant_items).serialized_json
  end

end
