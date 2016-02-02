class ChangeDefaultImageForBunkers < ActiveRecord::Migration
  def change
    change_column :bunkers, :image, :string, default: "https://upload.wikimedia.org/wikipedia/commons/0/01/Albania_bunker_2.jpg"
  end
end
