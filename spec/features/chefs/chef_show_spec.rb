require 'rails_helper'

describe 'Chef show page' do
  before :each do
    @swede = Chef.create(name: "Bjorn, the Swedish Chef")
    @pasta = Dish.create(name: "Spaghetti and Meatballs",
                        description: "Pasta noodles with bits of meat",
                        chef_id: @swede.id)
    @sub = Dish.create(name: "Meatball Sub",
                      description: "A warm sandwich with spicy meatballs",
                      chef_id: @swede.id)
    @spaghetti = Ingredient.create(name: "spaghetti",
                                  calories: 200)
    @sauce = Ingredient.create(name: "tomato sauce",
                              calories: 150)
    @meatballs = Ingredient.create(name: "meatballs",
                                  calories: 250)
    @bread = Ingredient.create(name: "bread slices",
                              calories: "100")
    @cheese = Ingredient.create(name: "melted cheese",
                              calories: 175)
    DishIngredient.create(dish_id: @pasta.id, ingredient_id: @spaghetti.id)
    DishIngredient.create(dish_id: @pasta.id, ingredient_id: @sauce.id)
    DishIngredient.create(dish_id: @pasta.id, ingredient_id: @meatballs.id)
    DishIngredient.create(dish_id: @sub.id, ingredient_id: @meatballs.id)
    DishIngredient.create(dish_id: @sub.id, ingredient_id: @bread.id)
    DishIngredient.create(dish_id: @sub.id, ingredient_id: @cheese.id)
  end
  
  it "can show the ingredients a chef uses in their dishes" do
    visit "/chefs/#{@swede.id}"

    expect(page).to have_content(@swede.name)
    click_button "View All Ingredients"

    expect(current_path).to eq("/chefs/#{@swede.id}/ingredients")
    expect(page).to have_content(@spaghetti.name)
    expect(page).to have_content(@sauce.name)
    expect(page).to have_content(@meatballs.name, count: 1)
    expect(page).to have_content(@bread.name)
    expect(page).to have_content(@cheese.name)
  end

  it "can show the most popular ingredients a chef uses" do
    pizza = Dish.create(name: "Pepperoni Pizza",
                        description: "A pizza with pepperoni and cheese toppings",
                        chef_id: @swede.id)
    pepperoni = Ingredient.create(name: "pepperoni",
                                  calories: 225)
    DishIngredient.create(dish_id: pizza.id, ingredient_id: pepperoni.id)
    DishIngredient.create(dish_id: pizza.id, ingredient_id: @sauce.id)
    DishIngredient.create(dish_id: pizza.id, ingredient_id: @cheese.id)

    visit "/chefs/#{@swede.id}"
    expect(page).to have_content(@meatballs.name)
    expect(page).to have_content(@sauce.name)
    expect(page).to have_content(@cheese.name)
  end
end

# As a visitor
# When I visit a chef's show page
# I see the three most popular ingredients that the chef uses in their dishes
# (Popularity is based off of how many dishes use that ingredient)
