require 'pry'


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
