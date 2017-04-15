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

  def self.validate_install

    config = Kapten::Config::get

    unless config
      puts 'Kapten not initalized'.red
      puts 'Run "kapten init" to get started'.red
    end

    return config

  end


  def self.get_image(type)

    return Kapten::Helpers::TYPES[ type ]

  end


  def self.get_types

    return Kapten::Helpers::TYPES.keys

  end


  def self.remove(name)

    Kapten::DockerApi::destroy( name )

    File.delete( Kapten::Config::CONFIG_FILE )

  end

end
