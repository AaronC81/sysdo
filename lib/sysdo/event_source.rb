module Sysdo
  class EventSource
    attr_accessor :on_fire

    def initialize(&listener)
      @listener = listener
      @on_fire = ->{}
    end

    def fire(*args, **kwargs)
      @on_fire.(*args, **kwargs)
    end

    def listen
      @listener.(self)
      # TODO: what if this dies?
    end
  end
end
