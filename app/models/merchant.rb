class Merchant < ApplicationRecord
  self.primary_key = "id"

  def active_model_serializer
    MerchantSerializer
  end
end
