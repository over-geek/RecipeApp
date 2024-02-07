# spec/models/recipe_food_spec.rb

require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe) { Recipe.create(name: 'Test Recipe', user_id: 1) }
  let(:food) { Food.create(name: 'Test Food', measurement_unit: 'Grams', price: 5.99, user_id: 1) }
  let(:valid_attributes) do
    {
      recipe:,
      food:,
      quantity: 2
    }
  end

  it 'is valid with valid attributes' do
    recipe_food = RecipeFood.new(valid_attributes)
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a quantity' do
    recipe_food = RecipeFood.new(valid_attributes.except(:quantity))
    expect(recipe_food).to_not be_valid
  end

  it 'associates with a recipe' do
    recipe_food = RecipeFood.new(valid_attributes)
    expect(recipe_food.recipe).to eq(recipe)
  end

  it 'associates with a food' do
    recipe_food = RecipeFood.new(valid_attributes)
    expect(recipe_food.food).to eq(food)
  end
end
