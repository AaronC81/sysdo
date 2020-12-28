module Watchful
  class EventSource
    class PolledCollectionChange < EventSource
      def initialize(change, poll_rate = 1, &collection)
        raise "change parameter must be :add or :remove" \
          unless change == :add || change == :remove
        
        super() do |s|
          last = collection.()

          loop do
            now = collection.()
            if last != now
              if change == :add
                relevant_items = now - last
              elsif change == :remove
                relevant_items = last - now
              end

              relevant_items.each do |new_item|
                s.fire(new_item)
              end unless relevant_items.empty?
            end
            last = now

            sleep poll_rate
          end
        end
      end
    end
  end
end
