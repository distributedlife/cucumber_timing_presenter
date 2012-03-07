module DistributedLife
  class AllUsageResultsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize usage_record
      generate_html usage_record
    end

    def generate_html usage
      HtmlTemplate.new CucumberTimingPresenter::Configuration.usage_template_path
      HtmlTemplate.replace "PP_STEP_HIGHEST_AVERAGE", format_usage(usage.highest_average)
      HtmlTemplate.replace "PP_STEP_HIGHEST_ELAPSED_TIME", format_usage(usage.highest_elapsed_time)
      HtmlTemplate.replace "PP_STEP_GREATEST_VARIATION", format_usage(usage.greatest_variation)
      HtmlTemplate.replace "PP_STEP_HIGHEST_AVERAGE", format_all(usage.all)
      HtmlTemplate.output "all_usage_results.html"
    end
  end
end