require_relative 'treenode'
require 'byebug'
class KnightPathFinder
  attr_reader :visited_positions
  def initialize(pos)
    # @move_tree = new_move_positions(pos)
    @visited_positions = [PolyTreeNode.new(pos)]
  end

  def self.valid_moves(pos)
    x, y = pos
    all_moves = [
      [x - 2, y - 1],
      [x - 2, y + 1],
      [x - 1, y - 2],
      [x - 1, y + 2],
      [x + 1, y - 2],
      [x + 1, y + 2],
      [x + 2, y - 1],
      [x + 2, y + 1]
    ]
    all_moves.select do |position|
      position[0].between?(0, 7) && position[1].between?(0, 7)
    end

  end

  def new_move_positions(pos)
    valid = KnightPathFinder.valid_moves(pos)
    # byebug
    parent = @visited_positions.select { |node| node.value == pos }[0]

    valid.map! {|move| PolyTreeNode.new(move)}
    moves = valid.reject { |move| @visited_positions.include?(move) }

    moves.each do |node|
      parent.add_child(node)
    end

    @visited_positions.concat(moves)

    moves
  end

   def build_move_tree
     @visited_positions.each do |node|
       new_move_positions(node.value)
     end
   end

   def find_path(end_pos)
     self.build_move_tree
     node = @visited_positions.first.bfs(end_pos)
    #  byebug
      p trace_path_back(node)
   end

   def trace_path_back(node)
    #  byebug
     path = [node.value]
     until node.parent.nil?
       node = node.parent
       path.unshift(node.value)
     end
     path
   end
end

k = KnightPathFinder.new([0,0])

k.find_path([6,2])
