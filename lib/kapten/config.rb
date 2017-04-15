require 'json'

module Kapten::Config

  CONFIG_FILE = ".kapten.json"


  # Get config from current directory (.kapten.json file)
  def self.get

    return false unless File.file?( Kapten::Config::CONFIG_FILE )

    config_contents = File.read( Kapten::Config::CONFIG_FILE )

    config = JSON.parse(config_contents)

  end


  # Generate a basic config file
  def self.generate(type, name)

    config = {
      type: type,
      name: name,
    }

    return config

  end


  # Update config file with new data
  def self.save(config)
    File.write( Kapten::Config::CONFIG_FILE, config.to_json )
    return true
  end

end
