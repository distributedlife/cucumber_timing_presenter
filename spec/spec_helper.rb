# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["support/**/*.rb"].each {|f| require f}

require 'cucumber_timing_presenter'

RSpec.configure do |config|
  config.mock_with :rspec

  config.color_enabled = true
end