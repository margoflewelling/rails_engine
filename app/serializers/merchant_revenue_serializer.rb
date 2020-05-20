class MerchantRevenueSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue
end
