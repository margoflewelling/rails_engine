class AddUpdatedAtToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :updated_at, :string
    add_column :merchants, :created_at, :string
  end
end
