class HomeController < ApplicationController
  layout 'home'
  def index
    @title = 'Welcome to RecipeApp!'
    @foods = Food.all
  end
end
