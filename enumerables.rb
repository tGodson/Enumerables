module Enumerable
  def my_each
    i = 0
    while i < self.size
        yield(self[i])
        i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.size
        yield(self[i], i)
        i += 1
    end
    self
  end

  def my_select
    invited_list = []

    self.my_each do |x|
      if yield(x)
        invited_list.push(x)
      end
    end

    invited_list
  end

  def my_all?
    self.my_each do |x|
      if !yield(x)
        return false
      end
    end

    true
  end

  def my_any?
    self.my_each do |el|
      if yield(el)
        return true
      end
    end

    false
  end

  def my_none?
    self.my_each do |el|
      if yield(el)
        return false
      end
    end

    true
  end

  def my_count
    count = 0
    self.my_each { |i|
        if yield(i) == true
            count += 1
        end
    }
    count
  end
  
  def my_map(proc = nil, &block)
    new_array = []
    counter = 0
    while counter < self.length
      if proc && block_given?
        new_array << block.call(proc.call(self.to_a[counter]))
      elsif block_given?
        new_array << block.call(self.to_a[counter])
      elsif proc
        new_array << proc.call(self.to_a[counter])
      else
        return self.to_enum(:my_map) if !block_given?
      end
      counter += 1
    end
    new_array
  end

  def my_inject(arg = nil, &block)
    memo = arg if arg
    self.my_each do |element|
      if memo
        memo = block.call(memo, element)
      else
        memo = element
      end
    end
    memo
  end
  
  def multiply_els(arr)
      arr.my_inject {|x,y| x*y}
  end
end
