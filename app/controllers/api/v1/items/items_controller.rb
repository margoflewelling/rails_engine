class Api::V1::Items::ItemsController < ApplicationController

  def index
    @data = Item.all
    render json: ItemSerializer.new(@data).serializable_hash
  end

  def create
    @item = Item.create(item_params)
    render json: ItemSerializer.new(@item).serializable_hash
  end

  def destroy
    @item = Item.find(params["id"])
    render json: ItemSerializer.new(@item.delete).serializable_hash
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params)).serializable_hash
  end

  private

    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end

end
