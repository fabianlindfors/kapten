require 'docker'
require 'colorize'

module Kapten::DockerApi

  def self.get_container(name)

    begin

      container = Docker::Container.get(name)
      return container

    rescue

      return false

    end

  end


  def self.get_image(image)

    begin

      image = Docker::Image.get( image )
      return image

    rescue

      return false

    end

  end


  def self.start(name, image)

    container = Kapten::DockerApi::get_container(name)

    if not container

      # Pull image if not installed
      docker_image = Kapten::DockerApi::get_image( image )

      unless docker_image

        puts "First time running, installing environment (this might take a few minutes)...".green
        docker_image = Docker::Image.create( 'fromImage' => image )

      end


      puts "Creating environment...".green

      container = Docker::Container.create(
        'Image' => image,
        'name' => name,
        'Hostname' => name,
        'Cmd' => ['/bin/bash'],
        "OpenStdin" => true,
        "StdinOnce" => true,
        "Tty"       => true,
        "WorkingDir" => "/usr/src/" + name,
        "Hostconfig" => {
          "Binds" => [Dir.pwd + ":/usr/src/" + name]
        }
      )

    end

    container.start
    puts "---------------------------------".green
    puts 'Kapten: You\'re now inside the development environment, go wild! (use "exit" to get out of here)'.green

    require "io/console"
    STDIN.raw do |stdin|
      container.exec(["bash"], stdin: stdin, tty: true) do |chunk|
        print chunk
      end
    end

  end


  def self.stop(name)

    container = Kapten::DockerApi::get_container(name)

    if container

      container.stop
      return true

    end

    return false

  end


  def self.destroy(name)

    container = Kapten::DockerApi::get_container(name)

    if container

      container.stop
      container.delete(:force => true)
      return true

    end

    return false

  end

end
