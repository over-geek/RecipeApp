class HomeController < ApplicationController
  layout 'home'
  def index
    @title = 'Welcome to RecipeApp!'
  end
end
