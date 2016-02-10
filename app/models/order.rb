require "date"

class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  has_many :bunkers, through: :order_bunkers
  has_many :order_bunkers
  before_create :set_status
  
  scope :ordered, -> { where(status: "ordered") }
  scope :paid, -> { where(status: "paid") }
  scope :canceled, -> { where(status: "canceled") }
  scope :completed, -> { where(status: "completed") }

  def set_status
    self.status ||= "ordered"
  end

  def show_updated_status
    updated_at.strftime("%B %e, %Y") if order_closed?
  end

  def order_closed?
    status == "completed" || status == "canceled"
  end

  def formatted_date
    created_at.strftime("%B %e, %Y")
  end

  def bunker_quantities
    order_bunkers.each_with_object({}) do |ord_bunker, quantities|
      quantities[ord_bunker.bunker.title] = ord_bunker.quantity
    end
  end

  def bunker_quantity(bunker_id)
    order_bunkers.find_by(bunker_id: bunker_id).quantity
  end

  def bunker_subtotals
    bunkers.map do |bunker|
      bunker_subtotal(bunker.id)
    end
  end

  def bunker_subtotal(bunker_id)
    bunker = Bunker.find(bunker_id)
    order_bunker = order_bunkers.find_by(bunker_id: bunker_id)
    bunker.price * order_bunker.quantity
  end

  def total
    bunker_subtotals.sum
  end

  def self.filter_orders(status)
    where(status: status)
  end

  def self.set_status_breakdown
    group(:status).count
  end
end
