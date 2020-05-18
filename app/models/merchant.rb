class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  scope :filter_by_name, -> (name) {where("lower(name) like ?", "%#{name.downcase}%")}
  scope :filter_by_id, -> (id) {where id: id}

end
