class AddColumnToBunkers < ActiveRecord::Migration
  def change
    add_reference :bunkers, :store, index: true, foreign_key: true
  end
end
