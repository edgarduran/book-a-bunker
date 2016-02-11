class DropOutbreaksTable < ActiveRecord::Migration
  def change
    drop_table :outbreaks
  end
end
