class Merchant < ApplicationRecord

  def active_model_serializer
    MerchantSerializer
  end
end
