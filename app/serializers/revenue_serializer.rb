class RevenueSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue
end
