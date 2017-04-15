# O(n^2)
# def windowed_max_range(arr, w)
#   current_max_range = 0
#
#   arr.each_index do |idx1|
#     idx2 = idx1 + w - 1
#     next if idx2 >= arr.length
#     difference = arr[idx1..idx2].max - arr[idx1..idx2].min
#     current_max_range = difference if difference > current_max_range
#   end
#
#   current_max_range
# end
require 'byebug'

def optimized_max_range(arr, w)
  queue = StackQueue.new
  best_range = nil
# debugger
  arr.each_with_index do |el, i|
    queue.enqueue(el)
    queue.dequeue if queue.size > w

    if queue.size == w
      current_range = queue.max - queue.min
      best_range = current_range if (!best_range || (current_range > best_range))
    end


  end

  best_range
end

class MyStack
  def initialize(store = [])
    @store = store
  end

  def empty?
    @store.empty?
  end

  def peek
    @store.last
  end

  def pop
    @store.pop
  end

  def push(val)
    @store.push(val)
  end

  def size
    @store.size
  end
end

  class MinMaxStack
    def initialize
      @store = MyStack.new
    end

    def empty?
      @store.empty?
    end

    def min
      @store.peek[:min] unless empty?
    end

    def max
      @store.peek[:max] unless empty?
    end

    def peek
      @store.peek[:value] unless empty?
    end

    def pop
      @store.pop[:value] unless empty?
    end

    def push(val)
      # By using a little extra memory, we can get the max simply by peeking,
      # which is O(1).
      @store.push({
        max: new_max(val),
        min: new_min(val),
        value: val
      })
    end

    def size
      @store.size
    end

    private

    def new_max(val)
      empty? ? val : [max, val].max
    end

    def new_min(val)
      empty? ? val : [min, val].min
    end
  end

#our min max
class StackQueue
  def initialize
    @instack = MinMaxStack.new
    @outstack = MinMaxStack.new
  end

  def enqueue(el)
    @instack.push(el)
  end

  def dequeue
    if @outstack.empty?
      until @instack.empty?
        @outstack.push(@instack.pop)
      end
    end
    @outstack.pop
  end

  def max
    maxes = []
    maxes << @instack.max unless @instack.empty?
    maxes << @outstack.max unless @outstack.empty?
    maxes.max
  end

  def min
    mins = []
    mins << @instack.min unless @instack.empty?
    mins << @outstack.min unless @outstack.empty?
    mins.min
  end

  def size
    @instack.size + @outstack.size
  end

  def empty?
    @instack.empty? && @outstack.empty?
  end
end
#
#
p optimized_max_range([1, 0, 2, 5, 4, 8], 2) == 4
p optimized_max_range([1, 0, 2, 5, 4, 8], 3) == 5
p optimized_max_range([1, 0, 2, 5, 4, 8], 4) == 6
p optimized_max_range([1, 3, 2, 5, 4, 8], 5) == 6

# class MyQueue
#   def initialize
#     @store = []
#   end
#
#   def enqueue(el)
#     @store.push(el)
#   end
#
#   def dequeue
#     @store.shift
#   end
#
#   def peek
#     @store.first
#   end
#
#   def size
#     @store.size
#   end
#
#   def empty?
#     @store.empty?
#   end
# end
