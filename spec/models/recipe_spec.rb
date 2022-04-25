require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Recipe model' do
    before(:each) do
      @user = User.create name: 'Test user', email: 'test@gmail.com', password: '123456'
    end

    it 'name must not be blank' do
      recipe = Recipe.create name: '', cooking_time: 40, preparation_time: 5, description: 'test description',
                             public: true, user: @user
      expect(recipe).to_not be_valid
    end
  end
end
