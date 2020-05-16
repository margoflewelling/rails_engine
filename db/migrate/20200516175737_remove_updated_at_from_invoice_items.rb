class RemoveUpdatedAtFromInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :updated_at, :string
  end
end
