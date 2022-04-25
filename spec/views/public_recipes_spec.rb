require 'rails_helper'

RSpec.describe 'Testing public recipe views', type: :feature do
  describe 'PublicRecipe#index' do
    before(:each) do
      user = User.create name: 'Test', email: 'test@gmail.com', password: '123456'
      (1..4).each do |i|
        user.recipes.create name: "Test recipe #{i}", preparation_time: 40, cooking_time: 5, description: 'test',
                            public: true
      end

      visit new_user_session_path
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      visit public_recipes_path
    end

    it 'can see all the public recipes' do
      expect(page).to have_content 'Test 1'
      expect(page).to have_content 'Test 2'
      expect(page).to have_content 'Test 3'
      expect(page).to have_content 'Test 4'
    end

    it 'can see all the food item counts' do
      expect(page).to have_content 'Total food items: 0'
    end

    it 'should lead to recipe details' do
      click_on 'Test 1'
      expect(current_path).to eq recipe_path(Recipe.where(name: 'Test 1').first.id)
      expect(current_path).to_not eq recipe_path(Recipe.where(name: 'Test 2').first.id)
    end
  end
end
