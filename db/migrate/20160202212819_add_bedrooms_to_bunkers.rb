class AddBedroomsToBunkers < ActiveRecord::Migration
  def change
    add_column :bunkers, :bedrooms, :integer
  end
end
