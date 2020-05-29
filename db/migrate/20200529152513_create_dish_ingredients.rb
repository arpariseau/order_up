class CreateDishIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :dish_ingredients do |t|
      t.references :dish, foreign_key: true
      t.references :ingredient, foreign_key: true
    end
  end
end
