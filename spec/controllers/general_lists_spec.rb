require 'rails_helper'

RSpec.describe GeneralListController, type: :controller do
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
end
