module Sysdo
  module Cli
    CONFIG_DIRECTORY = File.join(
      ENV['XDG_CONFIG_HOME'] || File.expand_path('~/.config'),
      'sysdo',
    )

    def self.user_scripts
      create_config_directory
      Dir[File.join(CONFIG_DIRECTORY, '*.rb')]
    end

    def self.create_config_directory
      FileUtils.mkdir_p(CONFIG_DIRECTORY)
    end
  end
end
