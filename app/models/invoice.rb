class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :status, presence: true
  validates :merchant_id, presence: true
  validates :customer_id, presence: true

  def self.revenue_between(start_date, end_date)
    Invoice.joins(:invoice_items, :transactions)
           .merge(Transaction.successful)
           .where(invoices: { created_at: start_date .. end_date})
           .sum("invoice_items.unit_price * invoice_items.quantity")

  end

end
