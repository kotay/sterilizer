# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sterilizer/version'

Gem::Specification.new do |gem|
  gem.name          = "sterilizer"
  gem.version       = Sterilizer::VERSION
  gem.authors       = ["aTech Media"]
  gem.email         = ["hello@atechmedia.com"]
  gem.description   = %q{Guarantee a string}
  gem.summary       = "Libraries to ensure strings are always valid UTF-8"
  gem.homepage      = ""

  gem.license     = 'MIT'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.has_rdoc = false

  gem.homepage = "http://github.com/atech/atech"
  gem.add_dependency "rchardet19"
  gem.add_development_dependency 'pry'

end
