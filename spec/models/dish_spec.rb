require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end
  describe "methods" do
    it '#total_calories' do
      swede = Chef.create(name: "Bjorn, the Swedish Chef")
      pasta = Dish.create(name: "Spaghetti and Meatballs",
                          description: "Pasta noodles with bits of meat",
                          chef_id: swede.id)
      spaghetti = Ingredient.create(name: "spaghetti",
                                    calories: 200)
      sauce = Ingredient.create(name: "tomato sauce",
                                calories: 150)
      meatballs = Ingredient.create(name: "meatballs",
                                    calories: 250)
      DishIngredient.create(dish_id: pasta.id, ingredient_id: spaghetti.id)
      DishIngredient.create(dish_id: pasta.id, ingredient_id: sauce.id)
      DishIngredient.create(dish_id: pasta.id, ingredient_id: meatballs.id)

      calorie_count = spaghetti.calories + sauce.calories + meatballs.calories
      expect(pasta.total_calories).to eq(calorie_count)
    end
  end
end
