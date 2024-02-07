# spec/models/food_spec.rb

require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:valid_attributes) do
    {
      name: 'Test Food',
      measurement_unit: 'Grams',
      price: 5.99,
      user:
    }
  end

  it 'is valid with valid attributes' do
    food = Food.new(valid_attributes)
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = Food.new(valid_attributes.except(:name))
    expect(food).to_not be_valid
  end

  it 'is not valid without a measurement unit' do
    food = Food.new(valid_attributes.except(:measurement_unit))
    expect(food).to_not be_valid
  end

  it 'is not valid without a price' do
    food = Food.new(valid_attributes.except(:price))
    expect(food).to_not be_valid
  end

  it 'requires a unique name within the scope of the user' do
    Food.create(valid_attributes) # Create a food item with valid attributes
    food = Food.new(valid_attributes) # Attempt to create another food with the same name and user
    expect(food).to_not be_valid
  end

  it 'associates with user' do
    food = Food.new(valid_attributes)
    expect(food.user).to eq(user)
  end

  it 'associates with recipe_foods' do
    food = Food.new(valid_attributes)
    expect(food.recipe_foods).to be_empty
  end

  it 'associates with recipes through recipe_foods' do
    food = Food.new(valid_attributes)
    expect(food.recipes).to be_empty
  end
end
