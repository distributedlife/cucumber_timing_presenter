module DistributedLife
  class AllUsageResultsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize usage_record
      generate_html usage_record
    end

    def generate_html usage
      Template.new CucumberTimingPresenter::Configuration.usage_template_path
      Template.replace "PP_STEP_HIGHEST_AVERAGE", format_usage(usage.highest_average)
      Template.replace "PP_STEP_HIGHEST_ELAPSED_TIME", format_usage(usage.highest_elapsed_time)
      Template.replace "PP_STEP_GREATEST_VARIATION", format_usage(usage.greatest_variation)
      Template.replace "PP_STEP_HIGHEST_AVERAGE", format_all(usage.all)
      Template.output "all_usage_results.html"
    end
  end
end