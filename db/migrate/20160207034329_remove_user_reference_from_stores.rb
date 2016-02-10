class RemoveUserReferenceFromStores < ActiveRecord::Migration
  def change
    remove_column :stores, :user_id
  end
end
