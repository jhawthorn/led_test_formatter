require 'led_test_formatter'

module LEDTestFormatter
  class RSpec
    ::RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed, :start

    def initialize(output)
      @output = LEDTestFormatter::Hyperion.new
    end

    def start(notification)
      @status = Status.new(notification.count)
    end

    def tick(example_result)
      @status << example_result
      @output.report(@status)
    end

    def example_passed(notification)
      tick :passed
    end

    def example_pending(notification)
      tick :pending
    end

    def example_failed(notification)
      tick :failed
    end
  end
end
