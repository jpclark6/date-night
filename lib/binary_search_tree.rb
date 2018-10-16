require './lib/node'
require 'pry'

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value, title)
    if @root == nil
      @root = Node.new(value, title)
      return 0
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
            next_location_empty = true
          end
        else
          if node.right != nil
            node = node.right
            i += 1
          else
            node.right = Node.new(value, title)
            node.right.parent = node
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

    temp_i = 0

    until node.value == max.value
      temp_i += 1
      if temp_i > 1000
        return "FAILED"
      end

      #  sorted << {node.title => node.value}

      if node.left != nil
        node = node.left
      else
        if node.right != nil
          node = node.right
        else
          sorted << {node.title => node.value}
          node = node.parent
        end
      end
    end
    sorted
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

  end
end
