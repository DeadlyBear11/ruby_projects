# Create append method that adds a new value at the end of the List.
# For this I need:
# Method to create a new Node.
# Method to check if there's Nodes in the List.
# Method to check how many Nodes are there in the List.
# Method to link the last Node to the new Node.

class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :length

  def initialize
    @head = 0
    @tail = nil
    @length = 0
  end

  def create_node(value, next_node)
    @length += 1
    Node.new(value, next_node)
  end

  def empty?
    length.zero?
  end
end

my_list = LinkedList.new
p my_list.length
p my_list.empty?
p my_list.create_node(3000, "yeah")
p my_list.length
p my_list.empty?
