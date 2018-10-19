require './lib/node'
require 'pry'

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value, title)
    node = @root
    i = 0
    while node != nil
      parent_node = node
      node = value < node.value ? node.left : node.right
      i += 1
    end

    if has_root?
      parent_node.left = Node.new(value, title, parent_node, i) if value < parent_node.value
      parent_node.right = Node.new(value, title, parent_node, i) if value >= parent_node.value
    else
      @root = Node.new(value, title, nil, i)
    end
    i
  end

  def has_root?
    @root != nil
  end

  def node_empty?(node)
    node == nil
  end

  def include?(value)
    node = @root
    while node != nil
      if node.value == value
        return true
      end
      node = value < node.value ? node.left : node.right
    end
    false
  end

  def depth_of(value)
    node = @root
    i = 0
    until node.value == value
      node = value < node.value ? node.left : node.right
      i += 1
    end
    i
  end

  def max
    node = @root
    while node.right
      node = node.right
    end
    node
  end

  def min
    node = @root
    while node.left
      node = node.left
    end
    node
  end

  def sort
    node = @root
    sorted = []

    until node.value == max.value
      if node.left
        node = node.left
      else
        sorted << {node.title => node.value}
        node = delete_node(node)
      end
    end
    sorted << {node.title => node.value}
    sorted
  end

  def delete_node(node)
    if node.right == nil
      node = node.parent
      node.left = nil
    else
      node.right.parent = node.parent
      node = node.right
      node.right = nil
    end
    node
  end

  def load(file)
    total = 0
    File.open(file, "r") do |f|
      f.each_line do |line|
        value = line.split(", ")[0].to_i
        title = line.split(", ")[1].chomp
        unless include?(value)
          insert(value, title)
          total += 1
        end
      end
    end
    total
  end

  def health(level)
    active_nodes = [@root]
    level.times do |i|
      temp_nodes = active_nodes.clone
      temp_nodes.each do |node|
        active_nodes << node.left unless node.left == nil
        active_nodes << node.right unless node.right == nil
        active_nodes.shift
      end
    end
    health_report = []
    active_nodes.each do |node|
      health_report << [node.value, children(node.value) + 1, 100 * (children(node.value) + 1) / (children(@root.value) + 1)]
    end
    health_report
  end

  def find_node(value)
    node = @root
    until node.value == value
      node = value < node.value ? node.left : node.right
    end
    node
  end

  def children(value)
    active_children = [find_node(value)]
    total_children = 0
    until active_children.length == 0
      temp_children = active_children.clone
      temp_children.each do |node|
        unless node.left == nil
          active_children << node.left
          total_children += 1
        end
        unless node.right == nil
          active_children << node.right
          total_children += 1
        end
        active_children.shift
      end
    end
    total_children
  end

  def leaves
    active_children = [@root]
    total_leaves = 0
    until active_children.length == 0
      temp_children = active_children.clone
      temp_children.each do |node|
        unless node.left == nil
          active_children << node.left
        end
        unless node.right == nil
          active_children << node.right
        end
        if node.right == nil && node.left == nil
          total_leaves += 1
        end
        active_children.shift
      end
    end
    total_leaves
  end

  def height
    active_children = [@root]
    max_height = 0
    until active_children.length == 0
      temp_children = active_children.clone
      temp_children.each do |node|
        unless node.left == nil
          active_children << node.left
        end
        unless node.right == nil
          active_children << node.right
        end
        if node.level > max_height
          max_height = node.level
        end
        active_children.shift
      end
    end
    max_height
  end

end
