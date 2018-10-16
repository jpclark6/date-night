require './lib/node'
require 'pry'

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value, title)
    if @root == nil
      @root = Node.new(value, title)
      @root.parent = nil
      return @root.level = 0
    else
      i = 1
      node = @root
      next_location_empty = false
      until next_location_empty
        if value < node.value
          if node.left != nil
            node = node.left
            i += 1
          else
            node.left = Node.new(value, title)
            node.left.parent = node
            node.left.level = i
            next_location_empty = true
          end
        else
          if node.right != nil
            node = node.right
            i += 1
          else
            node.right = Node.new(value, title)
            node.right.parent = node
            node.right.level = i
            next_location_empty = true
          end
        end
      end
    end
    return i
  end

  def include?(value)
    node = @root
    return false if node == nil

    loop do
      if node.value == value
        return true
      end
      if value < node.value
        if node.left != nil
          node = node.left
        else
          return false
        end
      else
        if node.right != nil
          node = node.right
        else
          return false
        end
      end
    end
  end

  def depth_of(value)
    node = @root

    i = 0
    loop do
      if node.value == value
        return i
      end
      if value < node.value
        if node.left != nil
          node = node.left
          i += 1
        else
          return false
        end
      else
        if node.right != nil
          node = node.right
          i += 1
        else
          return false
        end
      end
    end
  end

  def max
    node = @root

    loop do
      if node.right != nil
        node = node.right
      else
        return node
      end
    end
  end

  def min
    node = @root

    loop do
      if node.left != nil
        node = node.left
      else
        return node
      end
    end
  end

  def sort
    node = @root
    sorted = []

    until node.value == max.value
      if node.left != nil
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
    # find all nodes on level, create that many element array
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
    # 1st value in each array is the value at node
    # 2nd value find all child nodes including node
    # 3rd value = 2nd value / total nodes
    active_nodes.each do |node|
      health_report << [node.value, children(node.value) + 1, 100 * (children(node.value) + 1) / (children(@root.value) + 1)]
    end
    health_report
  end

  def find_node(value)
    node = @root

    loop do
      if node.value == value
        return node
      end
      if value < node.value
        if node.left != nil
          node = node.left
        else
          return false
        end
      else
        if node.right != nil
          node = node.right
        else
          return false
        end
      end
    end
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
