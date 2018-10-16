require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class BinarySearchTreeTest < Minitest::Test
  def test_it_exists
    node = Node.new(50, "Movie")
    assert_instance_of Node, node
  end
end
