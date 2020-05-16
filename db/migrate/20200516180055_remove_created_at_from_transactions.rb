class RemoveCreatedAtFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :created_at, :string
  end
end
