require_relative 'source_library/usb'
require_relative 'source_library/network'
require_relative 'source_library/battery'
require_relative 'event_source'
require_relative 'event_source/polled_collection_change'
require_relative 'event_source/polled_equal_change'
require_relative 'event_source/polled_change'
require_relative 'dsl'

include Watchful::SourceLibrary

dsl = Watchful::DSL.new
dsl.instance_eval(File.read(File.join(__dir__, 'user_config.rb')))
threads = dsl.event_sources.map do |src|
  t = Thread.new { src.listen }
  t.abort_on_exception = true
  t
end

puts "Press Enter to end..."
gets

threads.each(&:kill)
