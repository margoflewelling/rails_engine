class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  validates :name, presence: true

  scope :filter_by_name, -> (name) { where("lower(name) like ?", "%#{name.downcase}%")}
  scope :filter_by_id, -> (id) { where id: id }
  scope :filter_by_created_at, -> (created_at) { where("created_at like ?", "#{created_at}%")}
  scope :filter_by_updated_at, -> (updated_at) { where("updated_at like ?", "#{updated_at}%") }

  def self.most_revenue(limit)
      select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(limit)
  end

  def self.most_items(limit)
     select("merchants.*, SUM(invoice_items.quantity) AS total_items_sold")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("total_items_sold DESC")
      .limit(limit)
  end

  def merchant_revenue(merchant_id)
    Merchant.select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .group(:id)
      .merge(Transaction.successful)
      .where(id: merchant_id)
  end

end
