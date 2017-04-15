require 'json'

module Kapten::Config

  CONFIG_FILE = ".kapten.json"

  def self.get

    return false unless File.file?( Kapten::Config::CONFIG_FILE )

    config_contents = File.read( Kapten::Config::CONFIG_FILE )

    config = JSON.parse(config_contents)

  end


  def self.generate(type, name)

    config = {
      type: type,
      name: name,
    }

    return config

  end


  def self.save(config)
    File.write( Kapten::Config::CONFIG_FILE, config.to_json )
    return true
  end

end
