module Sysdo
  class EventSource
    class PolledEqualChange < EventSource
      def initialize(equal, poll_rate = 1, &value)        
        super() do |s|
          last = value.()

          loop do
            now = value.()
            if last != now && now == equal
              s.fire(now)
            end
            last = now

            sleep poll_rate
          end
        end
      end
    end
  end
end
