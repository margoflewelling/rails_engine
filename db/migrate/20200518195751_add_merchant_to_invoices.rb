class AddMerchantToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :merchant, foreign_key: true
    add_reference :invoices, :customer, foreign_key: true
  end
end
