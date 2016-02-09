class AddStatusToStores < ActiveRecord::Migration
  def change
    add_column :stores, :approved, :boolean
  end
end
