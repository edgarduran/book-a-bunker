class ChangeBunkersForeignKeyFromCategoryToLocation < ActiveRecord::Migration
  def change
    add_reference :bunkers, :location, index: true, foreign_key: true
  end
end
