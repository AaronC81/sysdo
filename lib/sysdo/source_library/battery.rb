module Sysdo
  module SourceLibrary
    module Battery
      def self.charger_connected
        EventSource::PolledEqualChange.new(true) { charger_connected? }
      end

      def self.charger_disconnected
        EventSource::PolledEqualChange.new(false) { charger_connected? }
      end

      protected

      BATTERY = '/org/freedesktop/UPower/devices/battery_BAT0'

      def self.charger_connected?
        # Can be "fully-charged" or "charging", so this is easier
        battery_info['state'] != 'discharging'
      end

      def self.battery_info
        # World's most naive upower parser
        `upower -i "#{BATTERY}"`.each_line.map do |line|
          [$~['key'], $~['value']] if /^\s*(?<key>.+):\s*(?<value>.+)$/ === line
        end.compact.to_h
      end
    end
  end
end
