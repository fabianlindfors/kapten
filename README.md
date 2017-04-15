# Kapten

Create simple and isolated development environments from the command line. Say goodbye to dependency issues, language version management, and complicated setups.

Supports:
- Ruby
- Python
- Node.js
- Elixir
- PHP
- Go
- Haskell
- Java
- Perl


## Installation

`$ gem install kapten`

Kapten is built upon and requires [Docker](https://www.docker.com).


## Usage

Creating a development environment with Kapten requires only two commands. Start by navigating to your project's root directory and run:

`$ kapten init ruby|python|node|elixir|php|go|haskell|java|perl`

After initialization you can start your environment by running:

`$ kapten start`

Your isolated environment will now set itself up and once finished boot into a shell with all the necessities for your chosen language. If you need more than one shell simply run `kapten start` again.

### Docker and containers

Kapten environments are really barebones Docker containers into which your projects files are mounted. The containers will continue running in the background after you disconnect. It's recommended to stop an environment with `$ kapten stop` once finished.

More commands:
```
# Get info about the current environment and its status.
$ kapten info

# Remove environment and container. Use 'kapten start' to start fresh.
$ kapten destroy

# Fully remove Kapten from your project.
$ kapten remove```

## License
Kapten is licensed under [MIT](https://github.com/Fabianlindfors/kapten/blob/master/LICENSE).
