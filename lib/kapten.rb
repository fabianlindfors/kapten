require 'thor'
require 'colorize'

module Kapten;end

require 'kapten/helpers'
require 'kapten/docker'
require 'kapten/config'

class Kapten::CLI < Thor

  desc 'init [TYPE]', 'Initalize Kapten in the current directory'
  method_option :name, :aliases => "-n", :desc => "Specify a name. Defaults to the current directory name."
  long_desc <<-LONGDESC
    Initalize Kapten in the current directory with a specified environment type

    Available types are: #{Kapten::Helpers::get_types.join(', ')}
  LONGDESC
  def init(type)

    if Kapten::Config.get
      puts 'Environment already initialized'
      puts 'Use "kapten start" to get developing'
      return
    end

    types = Kapten::Helpers::get_types

    if not types.include?(type)
      puts 'No such environment type'.red
      puts 'Available environment types are: ' + types.join(', ')
      return
    end

    name = options[:name] ||  File.basename(Dir.getwd)

    config = Kapten::Config::generate(type, name)

    Kapten::Config::save(config)

    puts 'Kapten initialized!'.green
    puts 'Use "kapten start" to load your environment'

  end


  desc 'start', 'Run and attach environemnt'
  def start

    config = Kapten::Helpers::validate_install
    return unless config

    image = Kapten::Helpers::get_image( config['type'] )

    Kapten::DockerApi::start( config['name'], image )

  end


  desc 'stop', 'Stop environment'
  def stop

    config = Kapten::Helpers::validate_install
    return unless config

    puts 'Stopping Kapten environment...'

    results = Kapten::DockerApi::stop( config['name'] )

    puts 'Environment no longer active!'.green

  end


  desc 'destroy', 'Destroy environment (use "kapten start" to recreate)'
  def destroy

    config = Kapten::Helpers::validate_install
    return unless config

    unless Kapten::DockerApi::get_container( config['name'] )

      puts 'No environment to destroy!'
      puts 'Run "kapten start" to set it up'
      return

    end


    puts 'Destroying environment...'

    results = Kapten::DockerApi::destroy( config['name'] )

    puts 'Environment destroyed! Rebuild it by running "kapten start".'.green

  end


  desc 'info', 'Info about current environment'
  def info

    config = Kapten::Helpers::validate_install
    return unless config

    container = Kapten::DockerApi::get_container( config["name"] )

    if not container
      status = 'Not created'
    else
      status = "Not running".yellow
      status = "Running".green if container.json["State"]["Running"]
    end

    puts ''
    puts 'Name:    ' + config['name']
    puts 'Type:    ' + config['type']
    puts 'Status:  ' + status
    puts ''

  end


  desc 'remove', 'Fully remove Kapten from the current project'
  def remove

    config = Kapten::Helpers::validate_install
    return unless config

    Kapten::Helpers::remove( config['name'] )

    puts 'All traces of Kapten have been removed'.green

  end

end
