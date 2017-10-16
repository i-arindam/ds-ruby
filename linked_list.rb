require 'pry'
class Node
  attr_accessor :val, :next

  def initialize(val, next_node)
    @val = val
    @next = next_node
  end
end

class LinkedList
  attr_accessor :head
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

  def delete_element(key)
    return "Empty List" unless @head
    if @head.val == key
      old_head = @head
      @head = old_head.next
      cleanup(old_head)
      return
    end

    node = @head
    prev_node = node
    while node.next
      prev_node = node
      node = node.next
      break if node.val == key
    end
    return "Reached End" unless node

    prev_node.next = node.next
    cleanup(node)
  end

  def delete_at_position(n)
    node_to_be_deleted = get_nth_node(n)
  end

  def cleanup(node)
    puts "\nFreeing node: #{node.inspect}\n"
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

  def length_iterative
    count = 0
    node = @head
    while node
      count += 1
      node = node.next
    end
    count
  end

  def length_recursive(node)
    return 0 unless node
    1 + length_recursive(node.next)
  end

  # Algos:
  def swap_two_nodes(source_key, destination_key)
    return unless node = @head
    prev_node = nil
    while node
      if node.key == source_key
        source_prev_node = prev_node
        source_node = node
      elsif node.key == destination_key
        dest_prev_node = prev_node
        dest_node = node
      end
      prev_node = node
      node = node.next
    end
    source_prev_node.next = dest_node
    dest_prev_node.next = source_node

    old_next_for_source = source_node.next
    old_next_for_dest = dest_node.next
    dest_node.next = old_next_for_source
    source_node.next = old_next_for_dest
  end
end

ll = LinkedList.new(10)
ll.add_at_head(20)
ll.add_at_head(30)
ll.add_at_head(40)

puts "\n\nTesting simple insert n print with [40,30,20,10] \n\n"
p ll.inspect
ll.return_list.map do |node|
  puts node.val
end

puts "\n\nTesting add_after_node, with [25]\n\n"

second_node = ll.get_nth_node(2)
puts "Second node = #{second_node.val}, next = #{second_node.next.val}"

ll.add_after_node(25, second_node)

ll.return_list.map do |node|
  puts node.val
end

puts "\n\nTesting add at end with [5]\n\n"

ll.add_at_end(5)
ll.return_list.map do |node|
  puts node.val
end

puts "\n\nTesting delete with [20]\n\n"
ll.delete_element(20)
ll.return_list.map do |node|
  puts node.val
end

puts "\n\nTesting length iterative: #{ll.length_iterative}\n\n"
puts "\n\nTesting length recursive: #{ll.length_recursive(ll.head)}\n\n"

