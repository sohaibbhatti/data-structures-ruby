class Node
  attr_accessor :value, :next
  @value = 0
  @next = nil

  def initialize _value, _next
    @value = _value
    @next  = _next
  end
end

class LinkedList
  attr_accessor :head

  def initialize head=nil
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

  def print_node
    curr_node = @head
    while curr_node do
      puts curr_node.value
      curr_node = curr_node.next
    end
  end
end
