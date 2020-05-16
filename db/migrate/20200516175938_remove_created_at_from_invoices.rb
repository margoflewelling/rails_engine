class RemoveCreatedAtFromInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :created_at, :string
  end
end
