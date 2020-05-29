require 'rails_helper'

describe 'Chef show page' do
  it "can show the ingredients a chef uses in their dishes" do
    swede = Chef.create(name: "Bjorn, the Swedish Chef")
    pasta = Dish.create(name: "Spaghetti and Meatballs",
                        description: "Pasta noodles with bits of meat",
                        chef_id: swede.id)
    sub = Dish.create(name: "Meatball Sub",
                      description: "A warm sandwich with spicy meatballs",
                      chef_id: swede.id)
    spaghetti = Ingredient.create(name: "spaghetti",
                                  calories: 200)
    sauce = Ingredient.create(name: "tomato sauce",
                              calories: 150)
    meatballs = Ingredient.create(name: "meatballs",
                                  calories: 250)
    bread = Ingredient.create(name: "bread slices",
                              calories: "100")
    cheese = Ingredient.create(name: "melted cheese",
                              calories: 175)
    DishIngredient.create(dish_id: pasta.id, ingredient_id: spaghetti.id)
    DishIngredient.create(dish_id: pasta.id, ingredient_id: sauce.id)
    DishIngredient.create(dish_id: pasta.id, ingredient_id: meatballs.id)
    DishIngredient.create(dish_id: sub.id, ingredient_id: meatballs.id)
    DishIngredient.create(dish_id: sub.id, ingredient_id: bread.id)
    DishIngredient.create(dish_id: sub.id, ingredient_id: cheese.id)

    visit "/chefs/#{swede.id}"

    expect(page).to have_content(swede.name)
    click_button "View All Ingredients"

    expect(current_path).to eq("/chefs/#{swede.id}/ingredients")
    expect(page).to have_content(spaghetti.name)
    expect(page).to have_content(sauce.name)
    expect(page).to have_content(meatballs.name, count: 1)
    expect(page).to have_content(bread.name)
    expect(page).to have_content(cheese.name)
  end
end

# Story 3 of 3
# As a visitor
# When I visit a chef's show page
# I see the name of that chef
# And I see a link to view a list of all ingredients that this chef uses in their dishes
# When I click on that link
# I'm taken to a chef's ingredient index page
# and I can see a unique list of names of all the ingredients that this chef uses
