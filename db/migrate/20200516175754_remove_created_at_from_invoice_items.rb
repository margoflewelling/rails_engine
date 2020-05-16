class RemoveCreatedAtFromInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :created_at, :string
  end
end
