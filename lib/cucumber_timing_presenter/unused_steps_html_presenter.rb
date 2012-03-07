module DistributedLife
  class UnusedStepsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize unused_steps
      generate_html unused_steps
    end

    def generate_html unused_steps
      HtmlTemplate.new CucumberTimingPresenter::Configuration.unused_steps_template_path
      HtmlTemplate.replace "PP_UNUSED_STEPS", format_usage(unused_steps.all)
      HtmlTemplate.output "unused_steps.html"
    end
  end
end