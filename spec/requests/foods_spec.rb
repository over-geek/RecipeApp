require 'rails_helper'

RSpec.describe FoodsController, type: :request do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  describe 'GET #new' do
    it 'displays the new food item form' do
      # Simulate user authentication by setting the user's session data
      post user_session_path, params: { user: { email: user.email, password: user.password } }

      get new_food_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Add New Food Item')
    end
  end

  describe 'POST #create' do
    it 'creates a new food item' do
      # Simulate user authentication by setting the user's session data
      post user_session_path, params: { user: { email: user.email, password: user.password } }

      expect do
        post foods_path, params: { food: { name: 'New Food', measurement_unit: 'Grams', price: 9.99 } }
      end.to change(Food, :count).by(1)

      expect(response).to redirect_to(foods_path)
      follow_redirect!
      expect(response.body).to include('Food item added successfully.')
    end
  end
end
