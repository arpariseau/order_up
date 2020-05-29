require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end
  describe "methods" do
    it '#all_ingredients' do
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

      ingredient_list = swede.all_ingredients

      expect(ingredient_list[0].id).to eq(spaghetti.id)
      expect(ingredient_list[1].id).to eq(sauce.id)
      expect(ingredient_list[2].id).to eq(meatballs.id)
      expect(ingredient_list[3].id).to eq(bread.id)
      expect(ingredient_list[4].id).to eq(cheese.id)

      expect(ingredient_list[0].name).to eq(spaghetti.name)
      expect(ingredient_list[1].name).to eq(sauce.name)
      expect(ingredient_list[2].name).to eq(meatballs.name)
      expect(ingredient_list[3].name).to eq(bread.name)
      expect(ingredient_list[4].name).to eq(cheese.name)
      
      expect(ingredient_list[0].calories).to eq(spaghetti.calories)
      expect(ingredient_list[1].calories).to eq(sauce.calories)
      expect(ingredient_list[2].calories).to eq(meatballs.calories)
      expect(ingredient_list[3].calories).to eq(bread.calories)
      expect(ingredient_list[4].calories).to eq(cheese.calories)
    end
  end
end
