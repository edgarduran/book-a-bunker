class ChangeTitleToCity < ActiveRecord::Migration
  def change
    rename_column :locations, :title, :city 
  end
end
