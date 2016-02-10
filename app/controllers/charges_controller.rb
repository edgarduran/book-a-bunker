class ChargesController < ApplicationController
  def new
    @amount = (@cart.bunker_totals.sum) * 100
  end
end
