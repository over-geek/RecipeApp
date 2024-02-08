class HomeController < ApplicationController
  layout 'home'
  def index
    @title = 'Welcome to RecipeApp!'
    @foods = current_user.foods
  end
end
