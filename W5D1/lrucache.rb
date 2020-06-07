class LRUCache
    attr_accessor :data
    def initialize(size)
        @data = []
        @size = size
    end

    def count
      @data.length
    end

    def add(el)
        if @data.include?(el)
            @data.delete(el)
            @data << el
        elsif count >= @size
            @data.shift
            @data << el
        else
            @data << el
        end
    end

    def show
      p @data
    end

    private
    # helper methods go here!

end