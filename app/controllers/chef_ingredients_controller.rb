class ChefIngredientsController < ApplicationController
  def index
    chef = Chef.find(params[:id])
    @ingredients = chef.all_ingredients
  end
end
