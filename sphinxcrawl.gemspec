# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sphinxcrawl/version'

Gem::Specification.new do |gem|
  gem.name          = 'sphinxcrawl'
  gem.version       = Sphinxcrawl::VERSION
  gem.authors       = ['Jon Doveston']
  gem.email         = ['jon@doveston.me.uk']
  gem.description   = %q{Simple command to crawl a site and process html into a sphinx xmlstream}
  gem.summary       = %q{Simple command to crawl a site and process html into s sphinx xmlstream}
  gem.homepage      = 'https://github.com/hatoishi/sphinxcrawl'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.add_dependency('methadone', '~> 1.2.2')
  gem.add_dependency('nokogiri', '~> 1.5.5')

  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('webmock')
end
