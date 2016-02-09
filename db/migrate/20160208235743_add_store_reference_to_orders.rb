class AddStoreReferenceToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :store, index: true, foreign_key: true
  end
end
