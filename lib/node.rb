class Node
  attr_accessor :left, :right, :level, :value, :title, :parent

  def initialize(value, title, parent = nil, level = 0, left = nil, right = nil)
    @title = title
    @value = value
    @parent = parent
    @left = left
    @right = right
    @level = level
  end

  def info
    puts "Value: #{@value}"
    puts "Left: #{@left.value}" unless @left == nil
    puts "Right: #{@right.value}" unless @right == nil
    puts "Parent: #{@parent.value}" unless @parent == nil
  end
end
