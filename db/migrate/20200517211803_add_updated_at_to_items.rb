class AddUpdatedAtToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :updated_at, :string
    add_column :items, :created_at, :string
  end
end
