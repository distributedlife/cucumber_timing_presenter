module DistributedLife
  module CucumberTimingPresenter
    class Configuration
      def self.usage_template_path
        File.realpath("templates/usage.template.html")
      end
    end
  end
end