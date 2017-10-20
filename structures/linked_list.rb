class LinkedList
  attr_accessor :head

  def initialize(val = nil)
    if val.is_a?(Array)
      build_from_array(val, 0)
    else
      @head = node_class.new(val, nil)
    end
  end

  def node_class
    LinkedListNode
  end

  def empty?
    head.empty?
  end

  def build_from_array(array, position)
    this_node = node_class.new(array[position])
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
    new_head = node_class.new(val, @head.next)
    unless @head
      @head = new_head
      return
    end
    new_head.next = @head
    @head = new_head
  end

  def add_at_end(val)
    node = @head
    new_node = node_class.new(val, nil)
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
    new_node = node_class.new(data, prev_node.next)
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
end