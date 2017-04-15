Gem::Specification.new do |s|
  s.name        = 'kapten'
  s.version     = '0.1.2'
  s.summary     = "Simple containerized development environments directly from the command line"
  s.description = "Kapten is a tool for creating simple containerized development environments directly from the command line. Check out the Github repo for usage instructions."
  s.authors     = ["Fabian Lindfors"]
  s.email       = 'fabian@flapplabs.se'
  s.files       = ["lib/kapten.rb"]
  s.files      += Dir['lib/kapten/*.rb']
  s.files      += ['bin/kapten']
  s.executables = ['kapten']
  s.homepage    = 'https://github.com/fabianlindfors/kapten'
  s.license     = 'MIT'
end
