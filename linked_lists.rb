# prepend(value) adds a new value containing value to the start of the list.
# For this I need:
# For the head to point to the new node.
# For the new node to have a next_node attribute pointing to the last head.

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
    @values = []
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

  def prepend(value)
    @head = create_node(value, head)
  end

  def values
    @values = [] if @values
    push_values
  end

  def push_values(node = head)
    @values.push(node.value)
    return @values if last_node?(node)

    push_values(node.next_node)
  end
end

my_list = LinkedList.new
puts "Is the list empty? #{my_list.empty?}. It has #{my_list.size} nodes."
my_list.append(3000)
p my_list.values
puts "Is the list empty? #{my_list.empty?}. It has #{my_list.size} nodes."
my_list.append(6000)
my_list.append(9000)
p my_list.values
puts "The list has #{my_list.size} nodes."
my_list.prepend(2000)
p my_list.values
puts "The list has #{my_list.size} nodes."
puts "The head is #{my_list.head.value}. The tail is #{my_list.tail.value}."
