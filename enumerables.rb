module Enumerable
  def my_each
    i = 0
    while i < self.size
        yield(self[i])
        i += 1
    end
  end
end
