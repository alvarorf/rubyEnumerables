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

def my_all? (m)
  return m
end

def my_any? (m)
  return m
end

def my_none? (m)
  return m
end

def my_count (m)
  return m
end

def my_map (m)
  return m
end

def my_inject (m)
  return m
end




puts bubble_sort([3, 1, 7])
puts bubble_sort_by(%w[hi hello super hey hooy A]) { |left, right| left.length <=> right.length }

    