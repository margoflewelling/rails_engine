class RemoveUpdatedAtFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :updated_at, :string
  end
end
