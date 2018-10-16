require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test
  def test_it_exists
    tree = BinarySearchTree.new
    assert_instance_of BinarySearchTree, tree
  end

  def test_it_can_insert_val_and_return_depth
    tree = BinarySearchTree.new
    ex = tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 0, ex
    ex = tree.insert(16, "Johnny English")
    assert_equal 1, ex
    ex = tree.insert(92, "Sharknado 3")
    assert_equal 1, ex
    ex = tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal 2, ex
  end

  def test_it_knows_if_it_has_value
    tree = BinarySearchTree.new
    ex = tree.insert(61, "Bill & Ted's Excellent Adventure")
    ex = tree.insert(16, "Johnny English")
    ex = tree.insert(92, "Sharknado 3")
    ex = tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal true, tree.include?(16)
    assert_equal false, tree.include?(72)
  end

  def test_it_finds_depth_of_value
    tree = BinarySearchTree.new
    ex = tree.insert(61, "Bill & Ted's Excellent Adventure")
    ex = tree.insert(16, "Johnny English")
    ex = tree.insert(92, "Sharknado 3")
    ex = tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal 1, tree.depth_of(92)
    assert_equal 2, tree.depth_of(50)
  end

  def test_it_finds_the_max_value
    tree = BinarySearchTree.new
    ex = tree.insert(61, "Bill & Ted's Excellent Adventure")
    ex = tree.insert(16, "Johnny English")
    ex = tree.insert(92, "Sharknado 3")
    ex = tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal 92, tree.max.value
    assert_equal "Sharknado 3", tree.max.title
  end

  def test_it_finds_the_min_value
    tree = BinarySearchTree.new
    ex = tree.insert(61, "Bill & Ted's Excellent Adventure")
    ex = tree.insert(16, "Johnny English")
    ex = tree.insert(92, "Sharknado 3")
    ex = tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal 16, tree.min.value
    assert_equal "Johnny English", tree.min.title
  end

  def test_it_can_sort_a_list
    tree = BinarySearchTree.new
    ex = tree.insert(61, "Bill & Ted's Excellent Adventure")
    ex = tree.insert(16, "Johnny English")
    ex = tree.insert(92, "Sharknado 3")
    ex = tree.insert(50, "Hannibal Buress: Animal Furnace")
    expected = [{"Johnny English"=>16}, {"Hannibal Buress: Animal Furnace"=>50},
      {"Bill & Ted's Excellent Adventure"=>61}, {"Sharknado 3"=>92}]
    assert_equal expected, tree.sort
  end
end
