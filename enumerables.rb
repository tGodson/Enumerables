module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    counter = 0
    while counter < size
      yield(self[counter])
      counter += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    counter = 0
    index = 0
    while counter < size
      yield(self[counter, index])
      counter += 1
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    mutated_arr = []
    counter = 0
    while counter < length
      mutated_arr << (self[counter]) if yield(self[counter]) == true
      counter += 1
    end
    mutated_arr
  end

  def my_all?
    return to_enum(:my_all) unless block_given?

    yield all?(&:even?)
  end

  def my_any?
    return to_enum(:my_any) unless block_given?

    yield any?(&:even?)
  end

  def my_none?
    return to_enum(:my_none) unless block_given?

    yield none?(&:even?)
  end

  def my_count?
    return to_enum(:my_count) unless block_given?

    yield count? { |_el| el? }
  end

  def my_map?
    return to_enum(:my_map) unless block_given?

    yield my_map? { |el| el * el }
  end

  def my_inject
    return to_enum(:my_inject) unless block_given?

    yield reduce(:+)
  end

  def multiply_els(array)
    array.my_reduce { |el, next_el| el * next_el }
  end

  def my_map?(proc)
    return to_enum(:my_map) unless block_given?

    proc.new my_map? { |el| el * el }
  end

  def my_map(_block)
    proc = proc { 'in proc object block' }
    my_map(proc) { 'in anonymous block' }
  end
end
