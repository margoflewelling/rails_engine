class RemoveCreatedAtFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :created_at, :string
  end
end
