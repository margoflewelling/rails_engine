class RemoveCreatedAtFromMerchants < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :created_at, :string
  end
end
