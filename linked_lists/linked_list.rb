class Node
  attr_accessor :value, :next
  @value = 0
  @next = nil

  def initialize _value, _next
    @value = _value
    @next  = _next
  end

  def equals?(other_node)
    (@value == other_node.value) && (@next == other_node.next)
  end
end

class LinkedList
  attr_accessor :head

  def initialize(head=nil)
    @head = head
  end

  # Adds a node to the start of the Linked list
  def add_node(value)
    if @head
      @head = Node.new value, @head
    else
      @head = Node.new value, nil
    end
  end

  # Deletes a node if its present in the linked list
  def delete_node(value)
    return false unless @head
    curr_node = @head

    if @head.value == value
      @head = @head.next
      return true
    end

    while curr_node.next
      if value == curr_node.next.value
        curr_node.next = curr_node.next.next
        return true
      else
        curr_node = curr_node.next
      end
    end
  end

  def find_node(value)
    return false if @head.nil?
    curr_node = @head
    match = false
    while curr_node
      break if match = (curr_node.value == value)
      curr_node = curr_node.next
    end

    match
  end

  # Returns an array representation of nodes in reverse
  def reverse_traversal
    list_array = []
    recurse_reverse(@head)do |val|
      list_array << val
    end
    list_array
  end

  # Returns an array representation of nodes
  def traversal
    list_array = []
    curr_node = @head
    while curr_node do
      list_array << curr_node
      curr_node = curr_node.next
    end

    list_array
  end

  private

  def recurse_reverse(curr_node = @head, &blk)
    if curr_node
      recurse_reverse curr_node.next, &blk
      blk.call(curr_node)
    end
  end
end


