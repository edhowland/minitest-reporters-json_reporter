require_relative 'spec_helper'

require './blog'

class TestBlog < Minitest::Test

  def setup
    @blog = Blog.new
  end

  def test_title_is_treehouse
    assert_equal "Treehouse Blog", @blog.title
  end
end
