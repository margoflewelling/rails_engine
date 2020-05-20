class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions


  def self.revenue_between(start_date, end_date)
    Invoice.select("invoice.id")
           .includes(:invoice_items)
           .joins(:transactions)
           .merge(Transaction.successful)
           .where(invoices: { created_at: start_date .. end_date})
           .sum("invoice_items.unit_price * invoice_items.quantity")

  end

end

# Invoice.includes(:invoice_items).joins(:transactions).merge(Transaction.successful).count
# Invoice.includes(:invoice_items).sum("invoice_items.unit_price * invoice_items.quantity")
