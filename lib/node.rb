class Node
  attr_reader :value, :title
  attr_accessor :left, :right, :parent

  def initialize(value, title)
    @title = title
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

end
