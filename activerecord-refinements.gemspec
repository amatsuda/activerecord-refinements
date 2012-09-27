# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord-refinements/version'

Gem::Specification.new do |gem|
  gem.name          = "activerecord-refinements"
  gem.version       = Activerecord::Refinements::VERSION
  gem.authors       = ["Akira Matsuda"]
  gem.email         = ["ronnie@dio.jp"]
  gem.description   = 'Adding clean and powerful query syntax on AR using refinements'
  gem.summary       = 'ActiveRecord + Ruby 2.0 refinements'
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activerecord', ['>= 0']
  gem.add_development_dependency 'sqlite3', ['>= 0']
  gem.add_development_dependency 'rspec', ['>= 0']
end
