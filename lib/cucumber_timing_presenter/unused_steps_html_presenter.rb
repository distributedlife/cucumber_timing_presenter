module DistributedLife
  class UnusedStepsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize unused_steps
      generate_html unused_steps
    end

    def generate_html unused_steps
      Template.new CucumberTimingPresenter::Configuration.unused_steps_template_path
      Template.replace "PP_UNUSED_STEPS", format_usage(unused_steps.all)
      Template.output "unused_steps.html"
    end
  end
end