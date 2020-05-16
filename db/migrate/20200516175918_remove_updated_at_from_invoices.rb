class RemoveUpdatedAtFromInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :updated_at, :string
  end
end
