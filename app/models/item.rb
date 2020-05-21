class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, numericality: true

  scope :filter_by_name, -> (name) { where("lower(name) like ?", "%#{name.downcase}%") }
  scope :filter_by_description, -> (description) { where("lower(description) like ?", "%#{description.downcase}%") }
  scope :filter_by_unit_price, -> (unit_price) { where unit_price: unit_price }
  scope :filter_by_id, -> (id) { where id: id }
  scope :filter_by_merchant_id, -> (merchant_id) { where merchant_id: merchant_id}
  scope :filter_by_created_at, -> (created_at) { where("created_at like ?", "#{created_at}%") }
  scope :filter_by_updated_at, -> (updated_at) { where("updated_at like ?", "#{updated_at}%") }

end
