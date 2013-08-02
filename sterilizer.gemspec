# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sterilizer/version'

Gem::Specification.new do |gem|
  gem.name          = "sterilizer"
  gem.version       = Sterilizer::VERSION
  gem.authors       = ["Ben Thompson"]
  gem.email         = ["ben@atechmedia.com"]
  gem.description   = %q{Guarantee a string}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "rchardet19"
  gem.add_development_dependency 'pry'
end
