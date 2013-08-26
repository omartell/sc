# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','sc','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'sc'
  s.version = Sc::VERSION
  s.author = 'Oliver Martell'
  s.email = 'oliver@closingloops.com'
  s.homepage = 'http://closingloops.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Totally Awesome SoundCloud Command Line Player'
# Add your other files here if you make them
  s.files = %w(
bin/sc
lib/sc/version.rb
lib/sc.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','sc.rdoc']
  s.rdoc_options << '--title' << 'sc' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'sc'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.7.0')
end
