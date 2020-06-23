
module RecipeHelper

  def get_recipe_url raw_recipe_url
     raw_recipe_url.present? ? "http://#{raw_recipe_url}" : 'default-recipe-big'
  end


end
