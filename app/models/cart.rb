class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def add_bunker(bunker_id, days)
    contents[bunker_id.to_s] ||= 0
    contents[bunker_id.to_s] = days
  end


  def total
    contents.values.sum
  end

  def count_of(bunker_id)
    contents[bunker_id.to_s]
  end

  def cart_bunkers
    contents.map do |bunker_id, _quantity|
      Bunker.find(bunker_id)
    end
  end

  def bunker_subtotal(bunker_id)
    bunker = Bunker.find(bunker_id)
    contents[bunker_id.to_s] * bunker.price
  end

  def bunker_totals
    cart_bunkers.map do |bunker|
      bunker_subtotal(bunker.id)
    end
  end

  def cart_subtotal
    bunker_totals.sum
  end

  def update_quantity

  end
end
