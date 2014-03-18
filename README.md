# Capistrano::nodenv

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano', github: 'capistrano/capistrano', branch: 'v3'
    gem 'capistrano-nodenv', github: "platanus/nodenv"

And then execute:

    $ bundle --binstubs
    $ cap install

## Usage

    # Capfile

    require 'capistrano/nodenv'

    set :nodenv_type, :user # or :system, depends on your nodenv setup
    set :nodenv_node, '0.10.3'
    set :nodenv_roles, :all # default value

If your nodenv is located in some custom path, you can use `nodenv_custom_path` to set it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
