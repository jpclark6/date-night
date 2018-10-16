class Node
  attr_accessor :left, :right, :level, :value, :title, :parent

  def initialize(value, title)
    @title = title
    @value = value
    @parent = nil
    @left = nil
    @right = nil
    @level = nil
  end

  def info
    puts "Value: #{@value}"
    puts "Left: #{@left.value}" unless @left == nil
    puts "Right: #{@right.value}" unless @right == nil
    puts "Parent: #{@parent.value}" unless @parent == nil
  end
end
