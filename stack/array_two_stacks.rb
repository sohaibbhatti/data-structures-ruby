# implement two stacks in one array A[1..n] in such a way that
# neither stack overﬂows unless the total number of elements in both stacks together
# is n.The PUSH and POP operations should run in O(1) time


# Strategy
# Populate one stack from index 0 towards index n.(top maintained by stack_one_top)
# Populate second stack from index n towards index 0(top maintained by stack_two_top)


class Stack
  attr_reader :array, :stack_one_top, :stack_two_top

  def initialize(array_length=10)
    @array = []
    @stack_one_top = 0
    @stack_two_top = array_length - 1
  end

  def push(stack_num, value)
    if stack_num == 1
      if @array[@stack_one_top].nil?
        @array[@stack_one_top] = value
      else
        detect_overflow

        @stack_one_top += 1
        @array[@stack_one_top] = value
      end
    elsif stack_num == 2
      if @array[@stack_two_top].nil?
        @array[@stack_two_top] = value
      else
        detect_overflow

        @stack_two_top -= 1
        @array[@stack_two_top] = value
      end
    else
      raise ArgumentError('invalid stack number passed')
    end
  end

  def pop(stack_num)
    if stack_num == 1
      if @array[@stack_one_top] == nil
        raise 'Underflow'
      else
        x = @array[@stack_one_top]
        @array[@stack_one_top] = nil
        @stack_one_top -= 1 if @stack_one_top > 0
        return x
      end
    elsif stack_num == 2
      if @array[@stack_two_top] == nil
        raise 'Underflow'
      else
        x = @array[@stack_two_top]
        @array[@stack_two_top] = nil
        @stack_two_top += 1 if (@stack_two_top < @array.length - 1)
        return x
      end
    else
      raise ArgumentError('invalid stack number passed')
    end
  end

  private

  def detect_overflow
    raise 'Overflow' if @stack_one_top + 1 == @stack_two_top
  end

  def detect_underflow(stack_num)
    if (stack_num == 1 && @array[@stack_one_top].nil?) || (stack_num == 2 && @array[@stack_one_top].nil?)
      raise 'Underflow'
    end
  end
end

describe Stack do
  let(:stack) { Stack.new 4 }

  describe '#push' do
    context 'for stack 1' do
      it 'correctly adds the value to the array' do
        stack.push 1, 10
        stack.stack_one_top.should == 0
        stack.push 1, 20
        stack.stack_one_top.should == 1
        stack.array.should == [10, 20]
      end
    end

    context 'for stack 2' do
      it 'correctly adds the value to the array' do
        stack.push 2, 10
        stack.stack_two_top.should == 3
        stack.push 2, 20
        stack.stack_two_top.should == 2
        stack.array.should == [nil, nil, 20, 10]
      end
    end

    it 'handles overflows' do
      stack.push 1, 10
      stack.push 1, 20
      stack.push 2, 1
      stack.push 2, 2
      expect { stack.push 1, 1 }.to raise_error
    end
  end

  describe '#pop' do
    it 'returns the last element of the stack' do
      stack.push 1, 2
      stack.push 1, 3
      stack.push 2, 10
      stack.push 2, 11
      stack.pop(1).should == 3
      stack.pop(2).should == 11
      stack.pop(1).should == 2
      stack.pop(2).should == 10
    end

    it 'handles underflow' do
      stack.push 2, 10
      stack.pop 2
      expect { stack.pop 2 }.to raise_error
      expect { stack.pop 2 }.to raise_error
    end
  end
end
