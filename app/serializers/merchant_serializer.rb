class MerchantSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
