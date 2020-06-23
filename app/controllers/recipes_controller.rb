class RecipesController < ApplicationController
  def index
    @recipes = ContentfulService.new.perform(:recipes_list)
  end

  def show
    @recipe = ContentfulService.new.perform(:recipe_details, params[:id])
  end
end
