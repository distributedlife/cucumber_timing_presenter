module DistributedLife
  module CucumberTimingPresenter
    class Configuration
      def self.usage_template_path
        File.expand_path("templates/all_usage_results.html", __FILE__)
      end
    end
  end
end