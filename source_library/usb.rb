module Watchful
  module SourceLibrary
    module Usb
      def self.connected
        EventSource::PolledCollectionChange.new(:add) { attached_devices }
      end

      def self.disconnected
        EventSource::PolledCollectionChange.new(:remove) { attached_devices }
      end

      protected

      UsbDevice = Struct.new('UsbDevice', :name, :id, :bus, :device)

      def self.attached_devices
        `lsusb`.each_line.map do |line|
          UsbDevice.new($~['name'], $~['id'], $~['bus'].to_i, $~['device'].to_i) \
            if /^Bus (?<bus>\d+) Device (?<device>\d+): ID (?<id>.{4}:.{4}) (?<name>.+)$/ === line.strip
        end.compact
      end
    end
  end
end
