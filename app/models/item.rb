class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  scope :filter_by_name, -> (name) {where("lower(name) like ?", "%#{name.downcase}%")}
  scope :filter_by_description, -> (description) {where("lower(description) like ?", "%#{description.downcase}%")}
  scope :filter_by_unit_price, -> (unit_price) {where unit_price: unit_price}
  scope :filter_by_id, -> (id) {where id: id}
  scope :filter_by_merchant_id, -> (merchant_id) {where merchant_id: merchant_id}

end
