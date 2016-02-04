class AddBunkerReferenceToOrderBunkers < ActiveRecord::Migration
  def change
    add_reference :order_bunkers, :bunker, index: true, foreign_key: true
  end
end
