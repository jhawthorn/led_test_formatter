module LEDTestFormatter
  class Status
    def initialize(num_tests)
      @num_tests = num_tests
      @results = []
    end

    def <<(status)
      @results << status
    end

    def success?
      !@results.include?(:failed)
    end

    def complete?
      @results.size >= @num_tests
    end

    def complete_ratio
      if @num_tests == 0
        1.0
      else
        @results.size.to_f / @num_tests
      end
    end
  end
end
