class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def active_model_serializer
    MerchantSerializer
  end
end
