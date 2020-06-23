require 'contentful'

class ContentfulService


  # optional keys
  KEY_CONTENT_TYPE = 'content_type'.freeze
  KEY_ORDER = 'order'.freeze
  KEY_SKIP = 'skip'.freeze
  KEY_PAGE = 'Page'.freeze
  KEY_LIMIT = 'limit'.freeze

  #values
  KEY_RECIPE = 'recipe'.freeze
  KEY_ORDER = '-sys.createdAt'.freeze

  Recipe_list_options = []


  attr_reader :client

  def initialize
    @client = Contentful::Client.new(
      space: ENV['CONTENTFUL_SPACE_ID'],
      access_token: ENV['CONTENTFUL_DELIVERY_TOKEN'],
      dynamic_entries: :auto,
      raise_errors: false
    )
  end

  def perform(method_name, *arguments)
    begin
      self.send(method_name, *arguments)
    rescue => e
      puts "ContentFul Service Failed: #{e}"
      false
    end
  end

  private

  def recipes_list
    recipes = @client.entries(content_type: KEY_RECIPE , order: KEY_ORDER)
    recipes.to_a
  end

  def recipe_details(recipe_id)
    recipe = @client.entry(recipe_id)
  end
end
