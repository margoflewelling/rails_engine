class RemoveUpdatedAtFromMerchants < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :updated_at, :string
  end
end
