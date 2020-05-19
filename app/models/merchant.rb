class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  scope :filter_by_name, -> (name) { where("lower(name) like ?", "%#{name.downcase}%")}
  scope :filter_by_id, -> (id) { where id: id }
  scope :filter_by_created_at, -> (created_at) { where("created_at like ?", "#{created_at}%")}
  scope :filter_by_updated_at, -> (updated_at) { where("updated_at like ?", "#{updated_at}%") }

end
