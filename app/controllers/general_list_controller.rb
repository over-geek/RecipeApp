class GeneralListController < ApplicationController
  before_action :authenticate_user!

  def index
    @tot_price = 0
    @tot_count = 0
    @foods = Food.left_outer_joins(:recipe_foods).where(recipe_foods: { food_id: nil },
                                                        foods: { user_id: current_user.id })
    @foods.each do |t|
      @tot_price += t.price
      @tot_count += 1
    end
  end
end
