require 'rails_helper'

describe 'Dish show page' do
  before :each do
    @swede = Chef.create(name: "Bjorn, the Swedish Chef")
    @pasta = Dish.create(name: "Spaghetti and Meatballs",
                        description: "Pasta noodles with bits of meat",
                        chef_id: @swede.id)
    @spaghetti = Ingredient.create(name: "spaghetti",
                                  calories: 200)
    @sauce = Ingredient.create(name: "tomato sauce",
                              calories: 150)
    @meatballs = Ingredient.create(name: "meatballs",
                                  calories: 250)
    DishIngredient.create(dish_id: @pasta.id, ingredient_id: @spaghetti.id)
    DishIngredient.create(dish_id: @pasta.id, ingredient_id: @sauce.id)
    DishIngredient.create(dish_id: @pasta.id, ingredient_id: @meatballs.id)

    visit "/dishes/#{@pasta.id}"
  end
  it "can show ingredients of a dish" do
    expect(page).to have_content(@swede.name)
    expect(page).to have_content(@spaghetti.name)
    expect(page).to have_content(@sauce.name)
    expect(page).to have_content(@meatballs.name)
  end
  it "can show a calorie count of a dish" do
    calorie_count = @spaghetti.calories + @sauce.calories + @meatballs.calories
    expect(page).to have_content("Total Calorie Count: #{calorie_count}")
  end
end

# Story 2 of 3
# As a visitor
# When I visit a dish's show page
# I see the total calorie count for that dish.
