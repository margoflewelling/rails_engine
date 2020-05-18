class Merchant < ApplicationRecord
  has_many :items

  def active_model_serializer
    MerchantSerializer
  end
end
