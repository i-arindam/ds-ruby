module Algos
  module LinkedList
    class Everything
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
  end
end
