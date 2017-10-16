require 'pry'
class Node
  attr_accessor :val, :next

  def initialize(val, next_node)
    @val = val
    @next = next_node
  end
end

class LinkedList
  def initialize(val)
    @head = Node.new(val, nil)
  end

  def get_nth_node(n)
    node = @head
    n -= 1
    n.times do |i|
      return "Reached end" unless node
      node = node.next
    end
    node
  end

  def add_at_head(val)
    new_head = Node.new(val, @head.next)
    unless @head
      @head = new_head
      return
    end
    new_head.next = @head
    @head = new_head
  end

  def add_at_end(val)
    node = @head
    new_node = Node.new(val, nil)
    unless @head
      @head = new_node
      return
    end
    while node.next
      node = node.next
    end
    node.next = new_node
  end

  def add_after_node(data, prev_node)
    return "Cannot add to a null node" unless prev_node
    return "Broken pointer at given node" unless prev_node.next
    new_node = Node.new(data, prev_node.next)
    prev_node.next = new_node
  end

  def return_list
    current = @head
    elements = []
    while current
      elements << current
      current = current.next
    end
    elements
  end
end

ll = LinkedList.new(10)
ll.add_at_head(20)
ll.add_at_head(30)
ll.add_at_head(40)

puts "\n\nTesting simple insert n print \n\n"
p ll.inspect
ll.return_list.map do |node|
  puts node.val
end

puts "\n\nTesting add_after_node\n\n"

second_node = ll.get_nth_node(2)
puts "Second node = #{second_node.val}, next = #{second_node.next.val}"

ll.add_after_node(25, second_node)

ll.return_list.map do |node|
  puts node.val
end


puts "\n\nTesting add at end\n\n"

ll.add_at_end(5)
ll.return_list.map do |node|
  puts node.val
end