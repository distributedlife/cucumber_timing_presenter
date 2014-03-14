# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber_timing_presenter/version"

Gem::Specification.new do |spec|
  spec.name        = "cucumber_timing_presenter"
  spec.version     = DistributedLife::CucumberTimingPresenter::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Ryan Boucher"]
  spec.email       = ["ryan.boucher@distributedlife.com"]
  spec.summary     = <<-TEXT
    A cucumber formatter to help you find slow steps}
  TEXT
  spec.description = <<-TEXT
    A cucumber formatter that generates html documents showing which steps are contributing to slow build times}
  TEXT
  spec.homepage    = "http://github.com/distributedlife/cucumber_timings_presenter"
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/).reject { |f| f =~ /^samples\// }
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']


  # development
  #spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'rspec', '>= 2.14.1'

  # runtime
  spec.add_runtime_dependency 'awesome_print'
  spec.add_runtime_dependency 'cucumber'


end