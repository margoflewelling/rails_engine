class Api::V1::Items::ItemsController < ApplicationController

  def index
    @data = Item.all
    render json: ItemSerializer.new(@data).serializable_hash
  end
  
end
