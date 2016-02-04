class RemoveItemsForeignKeyFromOrderBunkers < ActiveRecord::Migration
  def change
    remove_column :order_bunkers, :item_id
  end
end
