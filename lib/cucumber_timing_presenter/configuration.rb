module DistributedLife
  module CucumberTimingPresenter
    class Configuration
      def self.usage_template_path
        File.expand_path("templates/all_usage_results.html", File.dirname(__FILE__))
      end

      def self.unused_steps_template_path
        File.expand_path("templates/unused_steps.html", File.dirname(__FILE__))
      end
    end
  end
end