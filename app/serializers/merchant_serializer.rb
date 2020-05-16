class MerchantSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
