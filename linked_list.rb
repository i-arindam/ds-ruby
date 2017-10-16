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

  def add_at_head(val)
    new_head = Node.new(val, @head.next)
    new_head.next = @head
    @head = new_head
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

p ll.inspect
ll.return_list.map do |node|
  puts node.val
end