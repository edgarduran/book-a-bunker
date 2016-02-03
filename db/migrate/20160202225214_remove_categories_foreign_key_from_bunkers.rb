class RemoveCategoriesForeignKeyFromBunkers < ActiveRecord::Migration
  def change
    remove_column :bunkers, :category_id
  end
end
