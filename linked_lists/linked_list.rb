require 'rspec'

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

  def print_node
    curr_node = @head
    while curr_node do
      puts curr_node.value
      curr_node = curr_node.next
    end
  end
end

describe 'LinkedList' do
  let(:list) { LinkedList.new }

  describe '#find_node' do
    subject {list.find_node 20}

    context 'List empty' do
      it { should be_false}
    end

    context 'List present and match found' do
      before { list.add_node(1); list.add_node(10); list.add_node(20) }
      it { should be_true }
    end

    context 'List present and no match' do
      before { list.add_node(1); list.add_node(21); list.add_node(30) }
      it { should be_false }
    end
  end
end
