require 'contentful'

module ContentfulHelper

  @client ||= Contentful::Client.new(
      space: ENV['CONTENTFUL_SPACE_ID'],
      access_token: ENV['CONTENTFUL_DELIVERY_TOKEN'],
      dynamic_entries: :auto,
      raise_errors: true
    )



  def self.recipe
    @client.entries(content_type: 'recipe').first
  end

  def self.all_recipeis
    @client.entries(content_type: 'recipe')
  end

  def all_recipeis
    recipes = []

    @client.entries(content_type: 'recipe', order: '-sys.createdAt').each_item do |recipe|
      recipe_fields = recipe.fields
      recipes << {
        id: recipe.id,
        title: recipe_fields[:title],
        image: recipe_fields[:photo] && "https:#{recipe_fields[:photo].url}"
      }
    end
    recipes
  end

  def recipe_detail(recipe_id)
    recipe = @client.entry(recipe_id)
    raise "#{recipe_id}: Opps recipe does not exsits or been removed. " if recipe.nil?

    recipe_fields = recipe.fields
    {
      title: recipe_fields[:title],
      description: recipe_fields[:description],
      image: recipe_fields[:photo] && "https:#{recipe_fields[:photo].url}",
      chef_name: recipe_fields[:chef] && recipe_fields[:chef].fields[:name],
      tags_list: recipe_fields[:tags] && recipe_fields[:tags].collect{ |tag| tag.fields[:name] }
    }
  end




end
