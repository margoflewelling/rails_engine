class Api::V1::ItemsController < ApplicationController

  def index
    data = Item.all
    render json: ItemSerializer.new(data).serialized_json
  end

  def show
    item = Item.find(params["id"])
    render json: ItemSerializer.new(item).serialized_json
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item).serialized_json
  end

  def destroy
    item = Item.find(params["id"])
    render json: ItemSerializer.new(item.delete).serialized_json
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params)).serialized_json
  end

  private

    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end

end
