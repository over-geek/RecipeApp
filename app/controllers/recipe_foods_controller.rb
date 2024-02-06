class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)

    if @recipe.user == current_user && @recipe_food.save
      flash[:success] = 'Ingredient successfully added'
      redirect_to @recipe
    else
      flash[:error] = 'Error adding ingredient'
      render :new
    end
  end

  def edit
    @recipe_food = @recipe.recipe_foods.find_by(id: params[:id])
  end

  def update
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'The ingredient was modified successfully!'
      redirect_to @recipe # Redirect to the show page for the updated food
    else
      flash[:alert] = @recipe_food.errors.full_messages.join(', ')
      render :edit # Render the edit page again with error messages
    end
  end

  def destroy
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food.destroy
      redirect_to @recipe, notice: 'Recipe food was successfully destroyed.'
    else
      flash[:alert] = 'Failed to destroy recipe food.'
      render :show
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end

  def set_recipe
    @foods = current_user.foods.all
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = @recipe.recipe_foods
    # Select the foods that are not in the recipe.
    @foods_not_in_recipe = @foods.where.not(id: @recipe_food.pluck(:food_id))
  end
end
