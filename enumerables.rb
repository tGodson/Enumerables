module Enumerable
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    invited_list = []

    my_each do |x|
      invited_list.push(x) if yield(x)
    end

    invited_list
  end

  def my_all?
    my_each do |x|
      return false unless yield(x)
    end

    true
  end

  def my_any?
    my_each do |el|
      return true if yield(el)
    end

    false
  end

  def my_none?
    my_each do |el|
      return false if yield(el)
    end

    true
  end

  def my_count
    count = 0
    my_each do |i|
      count += 1 if yield(i) == true
    end
    count
  end

  def my_map
    mapped = []
    my_each do |i|
      mapped << (proc.nil? ? proc.call(i) : yield(i))
    end
    mapped
  end

  def my_inject(arg = nil, &block)
    memo = arg if arg
    my_each do |element|
      memo = if memo
               block.call(memo, element)
             else
               element
             end
    end
    memo
  end

  def multiply_els(arr)
    arr.my_inject { |x, y| x * y }
  end
end
