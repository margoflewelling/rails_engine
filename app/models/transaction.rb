class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoices

  scope :successful, -> { where(result: "success") }
end
