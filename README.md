# Sysdo

Sysdo is a tiny automation framework for gluing bits of your Linux system
together. Sysdo provides events, and you write Ruby to do things automatically
when the events fire.

```ruby
# If we're on the go, automatically switch to power-saving CPU frequency
on Battery.charger_disconnected do
  `cpupower frequency-set -g powersave`
end

# Don't let Steam eat all of your data allowance when tethering
on Network.changed do |network|
  if network.ssid == "Aaron's Phone"
    `pkill -9 steam`
  end
end
```

If you've used Tasker on Android, or Shortcuts on iOS, or Automator on macOS,
this is somewhat similar in the things you can achieve (albeit a bit more
hands-on).

This isn't really ready for proper usage yet, but with a bit more polish and a
larger library of events, it's not far off!

## Usage

1. Install with `gem install sysdo`.
2. Create a `sysdo` directory under your user config directory (defaults to
`XDG_CONFIG_HOME`, or `~/.config` if that's unset).
3. Put some Ruby scripts in there. You can create as many as you like and 
   they'll all be loaded; the names don't matter as long as they end in `.rb`.
4. Run `sysdo start` to launch the Sysdo daemon.
