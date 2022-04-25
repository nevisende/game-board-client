require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET recipes#index' do
    before(:each) do
      user = User.create name: 'Test user', email: 'test@gmail.com', password: '123456'
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      get recipes_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      expect(response).to render_template(:index)
    end

    it 'renders correct content' do
      expect(response.body).to include('Recipes from Test user')
    end
  end

  describe 'GET /show' do
    before(:each) do
      user = User.create name: 'Test user', email: 'test@gmail.com', password: '123456'
      recipe = Recipe.create name: 'Test recipe', cooking_time: 40, preparation_time: 5,
                             description: 'test description', public: true, user: user
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      get recipe_path(recipe.id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      expect(response).to render_template(:show)
    end

    it 'renders correct content' do
      expect(response.body).to include('Test recipe')
      expect(response.body).to include('Cooking time: <span>40</span>')
      expect(response.body).to include('test description')
    end
  end
end
