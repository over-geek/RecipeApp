require 'rails_helper'

RSpec.describe 'Foods Index', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(email: 'saba@example.com', password: 'sabani', name: 'saba')
    @food = Food.create(name: 'Saba food', measurement_unit: 'test', price: 5, quantity: 2, user: @user)
    sign_in @user
    visit foods_path
  end

  it 'shows the header title' do
    expect(page).to have_content('Food List')
  end

  it 'shows the food details' do
    expect(page).to have_content(@food.name)
    expect(page).to have_content(@food.measurement_unit)
    expect(page).to have_content(@food.price)
    expect(page).to have_link('Delete')
  end
end
