module Enumerable
  def my_each
    index = 0
    array = to_a
    if block_given?
      for item in 0..array.length - 1
        yield(self[item])
      end
    else
      while index < array.size
        return to_enum(:my_each) unless block_given?

        yield self[index]
        index += 1
        return self
      end
    end
  end

  def my_each_with_index(index = 0)
    while index < self.size
      if block_given?
        yield self[index], index
        index += 1
      else
        return self
      end
    end
    self
  end

  def my_each_with_index(index = 0)
    while index < size
      return to_enum(:my_each_with_index) unless block_given?

      yield self[index], index
      index += 1
    end
    self
  end

  def my_all?(query = nil)
    obj = self
    if block_given?
      length.times { |index| return false unless yield obj[index] }
    elsif query.is_a? Regexp
      length.times { |index| return false unless obj[index].match query }
    elsif query.is_a? Class
      length.times { |index| return false unless obj[index].is_a? query }
    elsif query.is_a? Numeric or query.is_a? String
      length.times { |index| return false unless obj[index] == query }
    elsif query.is_a? Proc
      length.times { |index| return false unless yield(index) }
    else
      length.times { |index| return false unless obj[index] }
    end
    true
  end


  def my_any?(query = nil)
    obj = self
    if block_given?
      length.times { |index| return true if yield obj[index] }
    elsif query.is_a? Regexp
      length.times { |index| return true if obj[index].match query }
    elsif query.is_a? Class
      length.times { |index| return true if obj[index].is_a? query }
    elsif query.is_a? Numeric or query.is_a? String
      length.times { |index| return true if obj[index] == query }
    elsif query.is_a? Proc
      length.times { |index| return true if yield(index) }
    else
      length.times { |index| return true if obj[index] }
    end
    false
  end

  def my_none?(query = nil)
    obj = self
    if block_given?
      length.times { |index| return false if yield obj[index] }
    elsif query.is_a? Regexp
      length.times { |index| return false if obj[index].match query }
    elsif query.is_a? Class
      length.times { |index| return false if obj[index].is_a? query }
    elsif query.is_a? Numeric or query.is_a? String
      length.times { |index| return false if obj[index] == query }
    elsif query.is_a? Proc
      length.times { |index| return false if yield(index) }
    else
      length.times { |index| return false if obj[index] }
    end
    true
  end

  def my_count(query = nil)
    array = self
    count = 0
    if block_given?
      array.length.times { |item| count += 1 if yield(array[item]) }
    elsif !query.nil?
      array.length.times { |item| count += 1 if array[item] == query }
    elsif query.nil?
      count = array.length
    end
    count
  end

  def my_map(query = nil)
    if query.nil?
      return to_enum :my_map unless block_given?

      array = []
      to_a.my_each do |item|
        array.push(yield(item)) if block_given?
      end
      array
    elsif query.class == Proc or block_given?
      array = []
      my_each do |item|
        array << query.call(item)
      end
      array
    end
  end

  def my_inject(query = nil, query2 = nil )
    array = self.to_a
    # need to loop query indexes here
    if block_given?
      array.push(query)
      block_return = 1
      array.my_each do |item|
        block_return = yield(block_return, item)
      end
      block_return
    elsif query2.nil? and query.is_a? Symbol
      array.reduce(0) do |sum, num|
        sum << num.public_send(query, num += 1)
      end
      sum
    else
      array.push(query)
      array
    end
  end

  def multiply_els(array)
    array.to_a.my_inject(1) { |a, b| a * b }
  end
end
