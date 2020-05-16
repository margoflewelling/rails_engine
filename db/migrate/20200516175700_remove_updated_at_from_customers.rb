class RemoveUpdatedAtFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :updated_at, :string
  end
end
