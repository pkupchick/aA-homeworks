  class Stack
    def initialize
        @under_array = []
    end

    def push(el)
      @under_array.push(el)
      el
    end

    def pop
      @under_array.pop
    end

    def peek
      @under_array.last
    end
  end

s = Stack.new

p s.push(2)
