class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoices

  validates :quantity, numericality: { only_integer: true }
  validates :unit_price, numericality: true 
  validates :invoice_id, presence: true
  validates :item_id, presence: true

end
