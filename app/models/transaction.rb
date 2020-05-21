class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoices

  validates :credit_card_number, presence: true
  validates :result, presence: true
  validates :invoice_id, presence: true

  scope :successful, -> { where(result: "success") }

end
