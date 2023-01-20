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
  attr_reader :size, :value
  attr_accessor :head

  def initialize
    @head = nil
    @size = 0
  end

  def create_node(value = nil, next_node = nil)
    @size += 1
    Node.new(value, next_node)
  end

  def empty?
    size.zero?
  end

  def begin_list(value)
    @head = create_node(value)
  end

  def append(value)
    if empty?
      begin_list(value)
    else
      tail.next_node = create_node(value)
    end
  end

  def tail(node = head)
    return node if last_node?(node)

    tail(node.next_node)
  end

  def last_node?(node)
    return true if node.next_node.nil?

    false
  end
end

my_list = LinkedList.new
puts "The list is empty? #{my_list.empty?}. It has #{my_list.size} nodes."
my_list.append(3000)
puts "The list is empty? #{my_list.empty?}. It has #{my_list.size} nodes."
my_list.append(6000)
my_list.append(9000)
puts "The list is empty? #{my_list.empty?}. It has #{my_list.size} nodes."
puts "The head is #{my_list.head.value}. The tail is #{my_list.tail.value}."
