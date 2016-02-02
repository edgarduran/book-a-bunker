class RenameItemsToBunkers < ActiveRecord::Migration
  def change
    rename_table :items, :bunkers
  end
end
