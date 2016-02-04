class RenameOrderItemsToOrderBunkers < ActiveRecord::Migration
  def change
    rename_table :order_items, :order_bunkers
  end
end
