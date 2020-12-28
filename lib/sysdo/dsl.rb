module Sysdo
  class Dsl
    attr_reader :event_sources

    def initialize
      @event_sources = []
    end

    def on(event_source, &action)
      event_source.on_fire = action
      @event_sources << event_source
    end
  end
end
