module Enumerable
def my_each
  ind = 0
  while ind < self.size
      if block_given? 
          yield self[ind]
          ind += 1
          self
      else
          return self.to_a
      end
  end
end

def my_each_with_index
  ind = 0
  while ind < self.size
      if block_given? 
          yield self[ind], ind
          ind += 1
      else
          return self
      end
  end
end

def my_select
  return to_enum(:my_select) unless block_given? #It will return to enum if no block is found

  result = []
  my_each { |i| result << i if yield(i) }
  result
end

def my_all?(arg = UNDEFINED)
  unless block_given?
    if arg != UNDEFINED
      my_each { |x| return false unless arg === x }
    else
      my_each { |x| return false unless x }
    end
    return true
  end
  my_each { |i| return false unless yield(i) }
  true
end

def my_any?(arg = UNDEFINED, &block)
  unless block_given?
    if arg != UNDEFINED
      my_each { |x| return true if arg === x }
    else
      my_each { |x| return true if x }
    end
    return false
  end
  my_each { |i| return true if block.call(i) }
  false
end

def my_none?(arg = UNDEFINED, &block)
  !my_any?(arg, &block)
end


def my_count(arg = UNDEFINED)
  arr = if arg.is_a? String
          split('')
        else
          arg
        end
  count = 0
  unless block_given?
    if arg != UNDEFINED
      arr.my_each { |x| count += 1 if x == arg }
      return count
    end
    return length
  end
  my_each { |i| count += 1 if yield(i) }
  count
end

def my_map(my_proc = UNDEFINED)
  return to_enum(:my_map) unless block_given?

  result = []
  arr = to_a
  if my_proc == UNDEFINED
    arr.my_each_with_index { |_, y| result << yield(arr[y]) }
  else
    arr.my_each_with_index { |_, y| result << my_proc.call(arr[y]) }
  end
  result
end

def my_inject (m)
  return m
end
    