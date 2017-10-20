class LinkedListNode
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