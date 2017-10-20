require 'pry'
class Node
  attr_accessor :val, :next

  def initialize(val, next_node = nil)
    @val = val
    @next = next_node
  end

  def empty?
    @val.nil? && @next.nil?
  end

  def present?
    !empty?
  end

  def append(another)
    if empty?
      self.val = another.val
      self.next = nil
      return self
    else
      self.next = Node.new(another.val)
      return self.next
    end
  end
end

class LinkedList
  attr_accessor :head
  def initialize(val = nil)
    if val.is_a?(Array)
      build_from_array(val, 0)
    else
      @head = Node.new(val, nil)
    end
  end

  def build_from_array(array, position)
    this_node = Node.new(array[position])
    return this_node if array[position + 1].nil?
    this_node.next = build_from_array(array, position + 1)
    @head = this_node
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
  #   1. Swap 2 nodes without swapping the data, just by swapping the pointers
  #   @todos: [Cases]
  #     - any item is not present
  #     - both are same
  #     - any is head
  #     - any is tail
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

  # Algos:
  #   2. Reverse the linked list I & R [ 5 --> 10 --> 25 --> 30 --> 40]
  def reverse_iteratively
    return unless @head
    return unless @head.next
    node = @head
    prev = nil
    while node
      old_next = node.next
      node.next = prev
      prev = node
      node = old_next
    end
    @head = prev
  end

  def reverse_recursively(node)
    # binding.pry
    @head = node
    unless node.next
      return node
    end
    if node.next
      # binding.pry
      ret = reverse_recursively(node.next)
      # binding.pry
      ret.next = node
      node.next = nil if node.next == ret
    end
  end

  def empty?
    head.empty?
  end

  # [1 10]
  # [2 20 30]
  def self.merge_sorted_list_iteratively(list1, list2)
    list = LinkedList.new
    tail = list.head
    list1 = list1.head
    list2 = list2.head
    return nil if list1.empty? && list2.empty?

    while list1 || list2
      if !list1
        tail = tail.append Node.new(list2.val)
        list2 = list2.next
      elsif !list2
        tail = tail.append Node.new(list1.val)
        list1 = list1.next
      elsif list1.val <= list2.val
        tail = tail.append Node.new(list1.val)
        list1 = list1.next
      else
        tail = tail.append Node.new(list2.val)
        list2 = list2.next
      end
    end
    list
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

puts "\n\nTesting length iterative: #{ll.length_iterative}"
puts "\n\nTesting length recursive: #{ll.length_recursive(ll.head)}\n\n"


puts "\n\nTesting reverse iteratively\n\n"
ll.reverse_iteratively
ll.return_list.map do |node|
  puts node.val
end

# puts "\n\nTesting reverse recursively\n\n"
# ll.reverse_recursively(ll.head)
# ll.return_list.map do |node|
#   puts node.val
# end

puts "\n\nTesting merge 2 lists iteratively\n\n"
l1 = LinkedList.new([1, 10])
l2 = LinkedList.new([2, 15, 20, 30])
l3 = LinkedList.merge_sorted_list_iteratively(l1, l2)
l3.return_list.map do |node|
  puts node.val
end
