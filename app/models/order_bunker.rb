class OrderBunker < ActiveRecord::Base
  belongs_to :order
  belongs_to :bunker
  before_create :update_quantity

  def update_quantity
    self.quantity ||= 1
  end
end
