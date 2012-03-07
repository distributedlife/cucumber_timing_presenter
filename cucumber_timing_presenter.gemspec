# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber_timing_presenter/version"

Gem::Specification.new do |s|
  s.name        = "cucumber_timing_presenter"
  s.version     = DistributedLife::CucumberTimingPresenter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Boucher"]
  s.email       = ["ryan.boucher@distributedlife.com"]
  s.homepage    = "http://github.com/distributedlife/cucumber_timings_presenter"
  s.summary     = %q{A cucumber formatter to help you find slow steps}
  s.description = %q{A cucumber formatter that generates html documents showing which steps are contributing to slow build times}

  s.add_dependency "cucumber"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end