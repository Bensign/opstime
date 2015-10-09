$:.unshift File.expand_path('../lib', __FILE__)

require 'opstime/version'

Gem::Specification.new do |gemspec|
  gemspec.name = 'opstime'
  gemspec.version = Opstime::VERSION
  gemspec.summary     = 'Scheduling system for infrastructure hosted on Digital Ocean.'
  gemspec.description = 'A ruby gem for scheduling of scaling up and down droplets on Digital Ocean.'
  gemspec.authors  = ['Ben Schaechter']
  gemspec.email    = ['bpschaechter@gmail.com']
  gemspec.rubygems_version = "0.0.1"
  gemspec.homepage = 'http://github.com/bensign/opstime'
  gemspec.license = 'MIT'
  gemspec.rdoc_options = ['--charset=UTF-8']
  gemspec.extra_rdoc_files = %w[README.md LICENSE]
  gemspec.files = `git ls-files`.split($/)
  gemspec.test_files = `git ls-files -- test`.split($/)
end