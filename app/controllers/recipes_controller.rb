class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_recipe_toggle, only: [:toggle]

  def index
    @user_recipes = Recipe.where(user_id: current_user.id)
    @user = current_user.recipes.includes(:user)
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe added successfully.'
    else
      render :new
    end
  end

  def show_for_purpose1
    @recipe = Recipe.find(params[:id])
    authorize! :destroy, @recipe
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was deleted successfully.'
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    @recipe.update(is_public: !@recipe.is_public)

    if @recipe.is_public?
      session[:public_recipes] ||= []
      session[:public_recipes] << @recipe.id
    elsif session[:public_recipes]
      session[:public_recipes].delete(@recipe.id)
    end

    respond_to do |format|
      format.html { redirect_to @recipe }
    end
  end

  def public_recipes
    @public_recipes = Recipe.where(is_public: true).order(created_at: :desc)
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe deleted successfully.'
  end

  private

  def authorize_recipe_toggle
    @recipe = Recipe.find(params[:id])
    return if @recipe.user_id == current_user.id

    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to recipes_path
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description)
  end
end
