module Watchful
  class EventSource
    class PolledChange < EventSource
      def initialize(poll_rate = 1, &value)        
        super() do |s|
          last = value.()

          loop do
            now = value.()
            if last != now
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
