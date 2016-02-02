class AddBathroomsToBunkers < ActiveRecord::Migration
  def change
    add_column :bunkers, :bathrooms, :integer
  end
end
