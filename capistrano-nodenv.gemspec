# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano-nodenv"
  gem.version       = '0.0.1'
  gem.authors       = ["Juan Ignacio Donoso"]
  gem.email         = ["jidonoso@gmail.com"]
  gem.description   = %q{nodenv integration for Capistrano}
  gem.summary       = %q{nodenv integration for Capistrano}
  gem.homepage      = "https://github.com/platanus/capistrano-nodenv"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano'

end
