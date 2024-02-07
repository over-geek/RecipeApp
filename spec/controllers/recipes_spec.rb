# spec/controllers/recipes_controller_spec.rb

require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) } # Assuming you have FactoryBot set up for user creation

  before do
    sign_in user # Authenticate the user using Devise
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:recipe) { create(:recipe, user:) } # Assuming FactoryBot for recipe creation

    it "returns http success for user's recipe" do
      get :show, params: { id: recipe.id }
      expect(response).to have_http_status(:success)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe' do
      post :create, params: { recipe: attributes_for(:recipe) } # Assuming FactoryBot for attributes
      expect(response).to redirect_to(recipes_path)
      expect(flash[:notice]).to be_present
    end
  end

  describe 'PATCH #toggle' do
    let(:recipe) { create(:recipe, user:) }

    it 'toggles is_public attribute' do
      patch :toggle, params: { id: recipe.id }
      recipe.reload
      expect(recipe.is_public).to eq(true)
    end
  end

  describe 'GET #public_recipes' do
    it 'returns http success' do
      get :public_recipes
      expect(response).to have_http_status(:success)
      expect(response).to be_successful
    end
  end

  # Additional tests for the "destroy" action
  describe 'DELETE #destroy' do
    let(:recipe) { create(:recipe, user:) }

    it "deletes the user's own recipe" do
      delete :destroy, params: { id: recipe.id }
      expect(response).to redirect_to(recipes_path)
      expect(flash[:notice]).to be_present
    end
  end
end
