require 'byebug'
class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent=(value_of_parent)
    old_parent = @parent

    old_parent.remove_child(self) unless old_parent.nil? || value_of_parent.nil?

    @parent = value_of_parent

    @parent.children << self unless @parent.nil?
  end

  def add_child(child_node)
    # self.children << child_node
    child_node.parent = self
  end

  def remove_child(child)
    self.children.delete(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    # return nil if self.children.empty?
    self.children.each do |child|
      search = child.dfs(target_value)
      next if search == nil
      return search if search.value == target_value
      # return child if search.value == target_value
      # return nil if self.children.empty?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    # queue.each do |node|
    queue.each do |node|
      return node if node.value == target_value
      # queue.shift
      queue.concat(node.children)
    end
    nil
  end

  def ==(other_node)
    @value == other_node.value
  end


  def inspect

    if @parent
      { 'value' => @value, 'parent_value' => @parent.value,
        'children' => @children}.inspect
    else
      { 'value' => @value, 'children' => @children}.inspect
    end

  end


end
