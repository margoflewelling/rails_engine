class ItemSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant_id
end
