require 'rspec'
require_relative 'linked_list'

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
