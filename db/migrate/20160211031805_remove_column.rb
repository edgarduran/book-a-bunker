class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :users, :latitude
    remove_column :users, :longitude
    remove_column :users, :safe_house
  end
end
