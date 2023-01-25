class Node
  include Comparable

  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end

class Tree
  def initialize(arr)
    @root = build_tree(arr)
  end

  def recurs_bst(arr)
    return nil if arr.length.zero?

    mid = arr.length / 2

    root = Node.new(arr[mid])

    root.left = recurs_bst(arr[0...mid])

    root.right = recurs_bst(arr[mid + 1..])

    root
  end

  def build_tree(arr)
    recurs_bst(arr.sort.uniq)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

my_arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

my_tree = Tree.new(my_arr)
my_tree.pretty_print
