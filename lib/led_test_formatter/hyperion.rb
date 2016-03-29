require 'socket'
require 'json'
require 'pp'

module LEDTestFormatter
  class Hyperion
    GREEN = [0, 255, 0].freeze
    RED = [255, 0, 0].freeze
    BLACK = [0, 0, 0].freeze

    attr_reader :num_leds
    def initialize
      @num_leds = 37
    end

    def report(status)
      color = status.success? ? GREEN : RED
      complete_count = (status.complete_ratio * num_leds).round
      incomplete_count = num_leds - complete_count
      set_color(color*complete_count + BLACK*incomplete_count)
    end

    def set_color(colors)
      response = request(command: 'color', color: colors, priority: 5, duration: 2000)
      response["success"] == true
    end

    def request(params)
      socket.puts(JSON.dump(params))
      JSON.parse(socket.gets)
    end

    def socket
      @socket ||= TCPSocket.new('localhost', 19444)
    end
  end
end
