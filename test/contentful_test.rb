require 'test_helper'
require 'contentful_helper'

class ContentfulTest < ActionDispatch::IntegrationTest
  include ContentfulHelper

  test "get an array of all the recipies" do
    res = ContentfulHelper.all_recipeis
    assert_not_equal(0, res.length)
  end

  test "get content for the first article" do
    res = ContentfulHelper.all_recipeis

    first = res.items.first

    # This test assumes the following fields on your content model:
    title = first.fields[:title]

    assert_equal("4dT8tcb6ukGSIg2YyuGEOm", first.id)
    assert_equal("White Cheddar Grilled Cheese with Cherry Preserves & Basil", title)
  end

  test "get space id" do
    cl = ContentfulHelper.recipe
    assert_equal(ENV['CONTENTFUL_SPACE_ID'], cl.space.id)
  end

end
