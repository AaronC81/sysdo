on Usb.connected do |dev|
  puts "Device connected! #{dev}"
end

on Usb.disconnected do |dev|
  puts "Device disconnected! #{dev}"
end

on Network.changed do |net|
  puts "Network changed! #{net}"
end

on Battery.charger_connected do
  puts "Charger connected"
end

on Battery.charger_disconnected do
  puts "Charger disconnected"
end

