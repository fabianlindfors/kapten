require 'colorize'

module Kapten::Helpers

  TYPES = {
    'ruby' => 'ruby:latest',
    'python' => 'python:latest',
    'node' => 'node:latest',
    'elixir' => 'elixir:latest',
    'php' => 'php:latest',
    'go' => 'golang:latest',
    'haskell' => 'haskell:latest',
    'java' => 'openjdk:latest',
    'perl' => 'perl:latest',
  }


  # Validate that Kapten is initalized and Docker is installed
  def self.validate_install

    config = Kapten::Config::get

    # Make sure a config exists (Kapten has been initialized)
    unless config
      puts 'Kapten not initalized'.red
      puts 'Run "kapten init" to get started'.red
      return false
    end

    # Make sure Docker is instsalled
    unless Kapten::DockerApi::has_docker?
      puts 'Kapten requires Docker'.red
      puts 'Install and then try running command again: https://www.docker.com'.red
      return false
    end

    return config

  end


  # Get Docker image by environment type
  def self.get_image(type)

    return Kapten::Helpers::TYPES[ type ]

  end


  # Get all available environment types
  def self.get_types

    return Kapten::Helpers::TYPES.keys

  end


  # Remove all traces of Kapten (stop and destory container, delete config file)
  def self.remove(name)

    Kapten::DockerApi::destroy( name )

    File.delete( Kapten::Config::CONFIG_FILE )

  end

end
