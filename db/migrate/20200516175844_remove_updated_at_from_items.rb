class RemoveUpdatedAtFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :updated_at, :string
  end
end
