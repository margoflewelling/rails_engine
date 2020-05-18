class Api::V1::Items::SearchController < ApplicationController

def find
  possible_items = check_params(params)
  items = (possible_items.detect{ |item| possible_items.count(item) == @query_params })
  render json: ItemSerializer.new(items).serialized_json
end

def find_all
  possible_items = check_params(params)
  items = possible_items.select{ |item| possible_items.count(item) == @query_params }.uniq
  render json: ItemSerializer.new(items).serialized_json
end

private

def check_params(params)
  @query_params = 0
  possible_items = []
  params.each do |key, value|
    if item_attributes.include?(key)
      @query_params += 1
      if value.to_i != 0
        possible_items << Item.where("#{key}": value.to_i)
      else
        possible_items << Item.where("lower(#{key}) like ?", "%#{value.downcase}%")
      end
    end
  end
  possible_items.flatten
end

def item_attributes
  ["name", "description", "unit_price", "merchant_id", "created_at", "updated_at"]
end

end
