# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbcop/version'

Gem::Specification.new do |spec|
  spec.name          = 'dbcop'
  spec.version       = Dbcop::VERSION
  spec.authors       = ['Salahutdinov Dmitry']
  spec.email         = ['dsalahutdinov@gmail.com']

  spec.summary       = 'Ruby project database linter'
  spec.description   = 'Ruby project database linter'
  spec.homepage      = 'https://github.com/dsalahutdinov/dbcop'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rails'
  spec.add_runtime_dependency 'pg'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'dotenv'
end
