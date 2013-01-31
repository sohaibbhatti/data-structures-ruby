require 'rspec'

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

describe 'Node' do
  let!(:node) { Node.new 1, nil }

  describe 'equals?' do

    context 'same' do
      let(:new_node) { Node.new 1, nil}
      specify { new_node.equals?(node).should be_true }
    end

    context 'different' do
      let!(:dummy_node) { Node.new(1, nil) }
      let(:new_node) { Node.new(1, dummy_node) }

      it { new_node.equals?(node).should be_false }
    end
  end
end

describe 'LinkedList' do
  let(:list) { LinkedList.new }

  describe '#delete_node' do
    subject { list.delete_node(10) }

    context 'List empty' do
      it { should be_false }
    end

    context 'List exists' do

      context 'Node present at the start of list' do
        before { list.add_node(5); list.add_node(4); list.add_node(3); list.add_node(10) }

        it { should be_true }
        specify { subject; list.traversal.collect(&:value).should == [3, 4, 5] }
      end

      context 'Node present in middle of list' do
        before { list.add_node(5); list.add_node(4); list.add_node(10); list.add_node(3) }

        it { should be_true }
        specify { subject; list.traversal.collect(&:value).should == [3, 4, 5] }
      end

      context 'Node present at the end of list' do
        before { list.add_node(10); list.add_node(5); list.add_node(4); list.add_node(3) }

        it { should be_true }
        specify { subject; list.traversal.collect(&:value).should == [3, 4, 5] }
      end

      context 'Node not found' do
        before { list.add_node(5); list.add_node(4); list.add_node(3) }

        it { should be_false }
        specify { subject; list.traversal.collect(&:value).should == [3, 4, 5] }
      end
    end
  end

  describe '#traversal' do
    subject { list.traversal.collect(&:value) }

    context 'List empty' do
      it { should == [] }
    end

    context 'List exists' do
      before { list.add_node(5); list.add_node(4); list.add_node(3) }
      it { should == [3, 4, 5] }
    end
  end

  describe '#reverse_traversal' do
    subject { list.reverse_traversal.collect(&:value) }

    context 'List empty' do
      it { should == [] }
    end

    context 'List exists' do
      before { list.add_node(5); list.add_node(4); list.add_node(3) }
      it { should == [5, 4, 3] }
    end
  end

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
