module Watchful
  module SourceLibrary
    # Only supports Wi-Fi
    module Network
      def self.changed
        EventSource::PolledChange.new { network_status }
      end

      protected

      NetworkStatus = Struct.new('NetworkStatus', :connected, :type, :ssid) do
        def connected?
          connected
        end
      end

      def self.network_status
        ssid = `iwgetid -r`.chomp
        if $?.success?
          NetworkStatus.new(true, :wifi, ssid)
        else
          NetworkStatus.new(false, nil, nil)
        end
      end
    end
  end
end
